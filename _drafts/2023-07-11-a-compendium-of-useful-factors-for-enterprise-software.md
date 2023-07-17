---
layout: post
title: A Compendium of Useful Factors for SaaS Enterprise Software
date: 2023-07-11 15:22 -0600
---

## Background: The Twelve-Factor App

Over a decade ago, [Adam Wiggins][1], co-founder of Heroku, published _[The
Twelve-Factor App][2]_, a sort of declaration of factors with which it is good
to build web applications. Wiggins noted some benefits of this factored approach
to software architecture, with a focus on “a triangulation on ideal practices
for app development, paying particular attention to the dynamics of the organic
growth of an app over time, the dynamics of collaboration between developers
working on the app’s codebase, and avoiding the cost of software erosion.”

I think a lot of developers gained not only operational ease from this
declaration, but also learned _which kinds of factors were necessary_ to create
and run web applications. The factors provided a sort of map and guide to the
terrain that developers would soon find themselves in.

## Starting Out with Enterprise Software: WorkOS

Another great effort in creating not only a map, but actual SaaS software,
designed to ease the entry of aspiring businesses into the _enterprise_ world
has been [WorkOS][3], founded by [Michael Grinich][4].

WorkOS aims to help businesses “cross the enterprise chasm” by providing
guidance and SaaS software to deliver many necessary enterprise-grade
capabilities that essentially all enterprise SaaS products will need.

Among the most critical capabilities that WorkOS provides are:

 * Single Sign-On (SSO)
 * SAML & OIDC Authentication
 * Multi-Factor Authentication (MFA)
 * OAuth Client Connections to Data Providers
 * Directory Sync, via SCIM & custom integrations
 * Audit Logs
 * Admin Portal for IT Servicing

These capabilities comprise an enormous amount of heavy lifting that each new
enterprise product need not implement themselves, and they form a sort of
bedrock of necessary capabilities for any enterprise product.

## Going Deeper: SaaS Enterprise App Factors

While WorkOS is ably paving the entry into the enterprise for many new products,
there is an opportunity to define a set of deeper enterprise capabilities, which
the largest organizations in the world have come to expect. These are often
small checkboxes on big RFPs, hiding enormous complexity of implementation.

More importantly, as we’ll see, _the cost of adding many of these capabilities
into a mature product vastly outweighs the cost of adding hooks or shims for
them, early on in your product’s development cycle_. This means that you may
have opportunities to outperform much larger competitors if your product is
successful and you are able to more quickly develop your feature set and bring
true enterprise capabilities to your customers, without dramatic software &
infrastructure refactoring.

### Compendium of Factors: Single SaaS Enterprise Products

It’s first important to understand the enterprise expectations for just those
SaaS products that are delivered on their own, as a cohesive and comprehensive
set of features, without other products complementing or alongside them.



### Compendium of Factors: SaaS Enterprise Product Portfolios


### Compendium of Factors: Extensible SaaS Enterprise Products


[1]: https://adamwiggins.com
[2]: https://12factor.net
[3]: https://workos.com
[4]: https://www.linkedin.com/in/grinich/


* 12factor.net
* WorkOS
  * SSO
  * Directory Sync
  * IT administration UI
  * Audit logs
  * Multi-factor auth
* Factors for a single enterprise product
  * Incident response & problem management
  * Observability
    * Logs, metrics, traces (all regionalized)
  * Tenant lifecycle management
    * Standard data schema for a tenant
    * Standard lifecycle events (create, update, delete, add/remove sub-object)
    * CRM integration
    * Orchestration-as-a-service
  * BYOK-ready injected data & transit encryption
    * Key rotation
    * Multi-key (envelope) encryption
      * Company key for support/debugging
    * Key manaagement/escrow (e.g. AWS KMS)
  * Data regionalization, access & control
    * Create new data tagged with a region
    * Read data
    * Update data region (move)
    * Delete data
      * Soft-delete as default, with delayed full delete
      * Signed deletion receipts
    * Allow or disallow movement of data
    * Record & access logs for a region
    * DR/failover to another region
  * Option to self-host all infrastructure components (FedRAMP/airgap prep)
  * Workflow engine
* Factors for a multi-product enterprise portfolio
  * Unified inbox
  * Notification management & dispatch
  * Cross-product integration bridge ()
  * Shared data platform for collection, transformation, sharing (e.g. Snowflake)
* Factors for an extensible enterprise product (or portfolio)
  * Developer API
  * Developer management portal
  * Custom UI integrations (widgets, screens)
  * Extensible data input
