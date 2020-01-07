sub vcl_recv {
    set req.backend_hint = application.backend();
}
