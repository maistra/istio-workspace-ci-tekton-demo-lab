package com.redhat.developer.demos.customer.rest;

import javax.ws.rs.core.MultivaluedHashMap;
import javax.ws.rs.core.MultivaluedMap;

import io.quarkus.runtime.annotations.RegisterForReflection;
import org.eclipse.microprofile.rest.client.ext.ClientHeadersFactory;

@RegisterForReflection
public class BaggageHeadersFactory implements ClientHeadersFactory {


    @Override
    public MultivaluedMap<String, String> update(MultivaluedMap<String, String> incomingHeaders, MultivaluedMap<String, String> clientOutgoingHeaders) {
        MultivaluedHashMap<String, String> headers = new MultivaluedHashMap<>();
        String userAgent = incomingHeaders.getFirst("user-agent");
        headers.putSingle("baggage-user-agent", userAgent);
        String userLocation = incomingHeaders.getFirst("user-location");
        headers.putSingle("user-location", userLocation);
        String ikeSession = incomingHeaders.getFirst("ike-session-id");
        headers.putSingle("ike-session-id", ikeSession);

        headers.putSingle("x-request-id", incomingHeaders.getFirst("x-request-id"));
        headers.putSingle("x-b3-traceid", incomingHeaders.getFirst("x-b3-traceid"));
        headers.putSingle("x-b3-spanId", incomingHeaders.getFirst("x-b3-spanId"));
        headers.putSingle("x-b3-parentspanid", incomingHeaders.getFirst("x-b3-parentspanid"));
        headers.putSingle("x-b3-sampled", incomingHeaders.getFirst("x-b3-sampled"));
        headers.putSingle("x-b3-flags", incomingHeaders.getFirst("x-b3-flags"));
        headers.putSingle("b3", incomingHeaders.getFirst("b3"));

        return headers;
    }

}
