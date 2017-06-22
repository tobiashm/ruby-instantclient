# Docker image for Ruby with Oracle Instant Client

Based on the official `ruby:slim` images.

Why not the `ruby:alpine` images? The Instant Client libraries are build against
`glibc` and uses some of the features that are not implemented in `musl libc`,
which is what Alpine linux uses.

## Oracle Instant Client

The Oracle Technology Network License Agreement does not allow for
redistribution of the `.rpm` packages for Oracle Instant Client.

So to build the Docker images, download the following packages from 
[Oracle Technology Network][]:

- Instant Client Package - Basic and Basic Lite
- Instant Client Package - SDK
- Instant Client Package - SQL*Plus

And place the `.rpm` files for each version in the respective folders.

[Oracle Technology Network]: http://www.oracle.com/technetwork/database/features/instant-client/index-097480.html
