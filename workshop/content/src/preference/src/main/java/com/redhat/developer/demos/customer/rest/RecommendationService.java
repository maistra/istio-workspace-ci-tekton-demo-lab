package com.redhat.developer.demos.customer.rest;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;

import org.eclipse.microprofile.rest.client.annotation.RegisterClientHeaders;
import org.eclipse.microprofile.rest.client.inject.RegisterRestClient;

@RegisterClientHeaders
@RegisterRestClient
public interface RecommendationService {

    @Path("/")
    @GET
    @Produces("text/plain")
    public String getPreference();

}
