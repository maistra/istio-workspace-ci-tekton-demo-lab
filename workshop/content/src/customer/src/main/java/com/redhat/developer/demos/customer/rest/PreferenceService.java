package com.redhat.developer.demos.customer.rest;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;

import org.eclipse.microprofile.rest.client.annotation.RegisterClientHeaders;
import org.eclipse.microprofile.rest.client.inject.RegisterRestClient;

@RegisterClientHeaders(BaggageHeadersFactory.class)
@RegisterRestClient
public interface PreferenceService {

    @Path("/")
    @GET
    @Produces("text/plain")
    String getPreference();

}
