acl profile {
   # Authorize the local IP address (replace with the IP found above)
   "a.b.c.d";
   # Authorize Blackfire servers
   "46.51.168.2";
   "54.75.240.245";
}

sub vcl_recv {
    set req.backend_hint = application.backend();
    set req.http.Surrogate-Capability = "abc=ESI/1.0";

    if (req.method == "PURGE") {
        if (req.http.x-purge-token != "PURGE_NOW") {
            return(synth(405));
        }
        return (purge);
    }

    # Don't profile ESI requests
    if (req.esi_level > 0) {
        unset req.http.X-Blackfire-Query;
    }

    # Bypass Varnish when the profile request comes from a known IP
    if (req.http.X-Blackfire-Query && client.ip ~ profile) {
        return (pass);
    }
}

sub vcl_backend_response {
    if (beresp.http.Surrogate-Control ~ "ESI/1.0") {
        unset beresp.http.Surrogate-Control;
        set beresp.do_esi = true;
    }
}
