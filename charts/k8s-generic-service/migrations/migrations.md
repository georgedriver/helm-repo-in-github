# Migrations to newer Chart versions

Migrating from an older chart to a newer chart can have many benefits. Some include security fixes, added deployment functionality, or added resiliency in the chart itself.

## [Upgrading from 0.1.x to 0.2.x](./0.1.x-0.2.x.md)
- Introduced multiple service port capabilities

## [Upgrading from 0.2.x to 0.3.x](./0.2.x-0.3.x.md)
- Introduced much more advanced service heal checking features

## [Upgrading from 0.3.x to 0.4.x](./0.3.x-0.4.x.md)
- Introduced a health check adapter for GRPC services
- Added the ability to specify JDBC database type for Flyway Jobs

## [Upgrading from 0.4.x to 0.5.x](./0.4.x-0.5.x.md)
- Added support for the gRPC<->JSON transcoder filter
