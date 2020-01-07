sub vcl_recv {
    set req.backend_hint = application.backend();
    set req.http.Surrogate-Capability = "abc=ESI/1.0";

    if (req.method == "PURGE") {
        if (req.http.x-purge-token != "PURGE_NOW") {
            return(synth(405));
        }
        return (purge);
    }
}

sub vcl_backend_response {
    if (beresp.http.Surrogate-Control ~ "ESI/1.0") {
        unset beresp.http.Surrogate-Control;
        set beresp.do_esi = true;
    }
}
