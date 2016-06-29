# Docker image for Ruby with Oracle Instant Client

Based on on the official `ruby:slim` images.

Why not the `ruby:alpine` images? The Instant Client libraries are build against
`glibc` and uses some of the features that are not implemented in `musl libc`,
which is what Alpine linux uses.
