---
title: The Best API Documentation
layout: post
tag: essay
lang: en
---

As a developer, I often need to make use of API documentation to understand how
to use a service on which I want to depend. Getting started from scratch is
always the biggest challenge and use of time, so I greatly appreciate those APIs
that are very well-documented. Some of them even make it _fun_ to learn.

## What makes the best API documentation?

Others like [Programmable Web][PW] and [Parse][PA] have written up some great
advice on this topic. I think the bar is being raised constantly and I will
attempt to add to their solid foundation.

I will assume that we are talking about a roughly hypermedia + REST HTTP API,
that being the format with which I’m most familiar and the only one to which I
could attribute the word “fun.” That said, these guidelines can be applied and
bent to most if not all API-like interfaces.

## Audiences

As with any product — and yes, API documentation is most certainly a product —
we need to start by understanding who needs to use it. I’ve come up with the
following audiences that I think represent the most significant fractions of
users, but there are undoubtedly more:

- Developer looking to get started — the **newcomer**
- Developer debugging a specific issue in an existing client — the **debugger**
- CTO evaluating competing APIs — the **decision maker**
- Product manager figuring out if X is possible with the API — the **searcher**

## Desired Features

Based on these audiences we can break down a series of the most desired features
beyond the most basic documentation of the existence of every call.

### Basics

I’ll assume that we’ve followed the advice from the above-mentioned posts and
established some basics: Document each and every call in your API separately,
with detailed notes on parameters and their possible values ([Stripe][SA] has
done this very well).

- Make the documentation for every call an example of that call being made, with
  details about the request and response ([GitHub][GI], for instance, does
  this).
- Use the all-docs-as-single-page approach recommended by Parse if your API
  isn’t enormous, such that in-page search can find anything quickly
  ([Stripe][SC] has one of the best single-page docs sites). After meeting that
  bare minimum, the rest of these features will be about building _great_ API
  docs.

### Descriptions in Plain English First

Most API docs just assume their audience is 100% developers, and further
(incorrectly) that those developers are completely familiar with the API’s
domain and jargon. Instead, you should strive to make the documentation for
every call intelligible _first_ to the **searcher**, who is trying to understand
which call does what to which nouns and why. I would recommend that you actually
_start_ your documentation process by writing these English domain explanations
for each call. It is also a great practice to link jargon and domain-specific
words to useful definitions the first time they are used in any given section.

These tactics will help you ensure clarity and good structure across your API at
the level of the domain and why certain calls exist, before you ever get lost in
the details of parameters, headers and responses. I’m not aware of any API docs
that currently do this well.

To satisfy the frequency of the **debugger** audience case, all API docs should
allow for quick reference to all of the functionality provided by the API,
logically organized. This usually means adopting things like a table of
contents, linkable section titles, a clearly (usually alphabetically) organized
list of resources & collections, and a consistent organization scheme for
sub-collections and verbs on each collection or resource. Every sub-section,
error-case or display state of the documentation should also be directly
linkable, which can be made even more obvious with a
linkable-tombstone-on-hover/focus interaction like GitHub does with headers in
their rendered Markdown.

[Stripe’s docs][SO] are pretty good for quick reference & linkability with their
persistent, expanding left-side table of contents for every call.

### Ease of Reading & Copying

Use large, clear fonts and high-contrast code formatting. Both your **debugger**
and your **newcomer** are going to be flipping back and forth between your docs
and their editor, which means anything you can do to make visual reorientation
easier is better. Consider using a font size a few points higher than you might
otherwise (18pt is great for prose, 21pt for code) and make sure that the
typeface you use for prose (I’d recommend Helvetica, Open Sans or related) is
visually distinct from the one you use for code and API responses (I’d go with
`Monaco, Consolas, "Droid Sans Mono"`).

Your users are also going to be copy/pasting a lot of code examples and URLs.
You should make that process very easy, maybe with an actual “Copy” button next
to those items, but at the very least with well-contained sections that include
only the bits you know will be copied a lot, making drag-to-highlight
interactions simple and error-free.

### Tutorials

Addressing the **newcomer** case head-on, tutorials should be step-by-step
introductions to using the API as if the developer has never before heard of
your company or service. The tutorial should integrate explanations of what the
various API resources and states _are_ (in a business or domain sense) while it
explains how to manipulate them.

Note that _authentication_ is often a topic unto itself, especially if you are
using [OAuth][OA] and especially for OAuth
request signing, which is a highly specific and error-prone process with
differing implementations in various language libraries, many of which are
subtly incorrect. Create a tutorial around these topics if you are relying on
OAuth.

Tutorials should strive to be clear, concise and evenly spaced across steps.
Remember that your **newcomer** has no previous experience with the resources
that you work with every day, but they are smart and they will learn quickly if
your tutorials are helpful and friendly.

[Braintree’s “Get Started” guide][BT] is a pretty good example of a detailed
step-by-step tutorial that takes you from zero to a working client.

There are many topics that will cut across all calls in your API, such as
authentication, pagination, standard error/retry handling, rate limiting, et
cetera. You should consolidate these topics in one place, under their own
headings, separate from your API calls. But then within the documentation for
each call you should indicate which global concerns apply to that call and link
to their sections. Remember that your audiences may be arriving on your docs
site for the very first time at the definition of a particular call, so they
wouldn’t know about e.g. rate limiting unless you link them to it from the
context of that individual call.

[GitHub tries to do this][GR] but only gets half way there by separating the
global concerns into their own sections, failing to link back to them from
individual calls.

Especially for your **newcomer**, it will be important to explain that all of
your API calls change behavior based on certain HTTP request headers like
`Accept`, `Authorization`, `Range`, `If-None-Match`, `If-Modified-Since`,
`X-YOURTHING-Api-Key`, etc. Be sure to explain clearly what each of the possible
values are for these headers, how to acquire or generate those values and how
their usage will modify the responses from the API.

### Explanation of Possible Responses

When describing your API responses, think not only of the format (e.g. JSON),
but also of HTTP response headers, your API’s error codes or messages and all
possible errors from a client’s perspective, including those out of control of
your API. The basics will cover the needs of a **newcomer** and by focusing on a
client’s perspective on the other side of an unreliable network, you can better
empathize with your **debugger**, improving not only their experience of writing
API clients but the quality of the clients written against your API.

Some things to include along with documented responses to each of your API
calls:

- A full sample response body in every supported response format (JSON, XML,
  etc.)
- All HTTP response headers relevant to your API, including the basic HTTP
  status code and message, and caching headers
- All possible error codes & messages that could appear in a response to the
  specific call, including those for global concerns like authentication and
  rate limiting
- All possible error conditions not controlled by your API, including: request
  timeout, HTTP proxy error, DNS lookup failure or unknown server error
- Recommended client behaviors to recover from or ignore known error codes or
  unknown error conditions (e.g. a request timeout) For instance, if you have a
  POST endpoint to create a new resource in a collection and the client receives
  an HTTP 503 Service temporarily unavailable response, you may want to advise
  clients to retry the exact request on an exponential backoff schedule for up
  to 5 minutes, probably via the Retry-After header. The details will of course
  depend on your API, but these are also behaviors that you can build into your
  supplied client libraries as sane defaults, and you should research similarly
  useful headers and behaviors in the [HTTP spec][HT] . I don’t know of any
  current API docs site that fully explains all possible errors from a client’s
  perspective (including network timeouts, DNS failures, etc.), but [Stripe at
  least explains][SE] their error codes and response formats. This is probably
  the most under-documented aspect of all current APIs.

### Examples in Multiple Client Technologies

For the **newcomer** and **debugger**, you should strive to represent typical
client use of your API from the perspective of multiple client technologies,
including [cURL][CU] and the most popular programming languages in use by web
and native client developers. Right now this means at least: C#, Java,
JavaScript, Kotlin, Go, PHP, Python, Ruby, Swift, and TypeScript. Your goal here
should be to represent _best practice usage_ of your API from the perspective of
each technology.

Creating these examples will require effort and vetting from people who actually
work with these languages to ensure that you aren’t giving bad advice or
contradicting best practices in that language’s local community. Similarly, you
should ensure that the examples in each language are at roughly the same level
of abstraction and use the language’s standard library. If you have written a
client library for a specific language and it is full-featured, you can consider
its use a best practice and so include it _in addition to_ the standard library
example. Give all of your users the freedom to choose whether to use your client
libraries independently of obtaining working example code in their language of
choice, though you can certainly recommend usage of your supported and
full-featured client library.

The purpose for including these code examples is to make them easier to copy for
usage in a client and to help enhance understanding by bridging the gap between
the abstract concept of an API call and concrete usage in a language with which
your user is familiar. You should not assume that your user is an expert
developer with years of experience in many languages, but instead do what you
can to make your docs more approachable and usable to a wide range of
developers.

You should also make this technology selection visually unobtrusive on your docs
site, as any given user of your docs will likely only need to make the choice
_once_ to select their preferred technology.

### API Keys in Sample Code & Commands

Mostly for your **newcomer**, if developers can log in to your API documentation
site (for instance, to manage their API keys), you should insert their API key
into any sample commands or code that you display, making it even easier for
them to paste and run them immediately.

If your site does not provide the ability to log in, or a user is not currently
logged in, you should provide a working test API key on all sample commands and
code to make the testing process as seamless as possible. It is best if your
test key is very obviously so, such as a highly repetitive pattern like
`00000000ffffffff` if you used hexadecimal keys. You can further aid the
developer by indicating the _test_ nature of such a response by including a
field in the response body itself or — the best option — by integrating a full
rate-limiting system with indicators in the response headers [like GitHub
does][GR]. That way you can keep the rate limit low for the test key per
requesting IP and increase the limit when using a real client key.

### Client Libraries in Multiple Languages

It’s non-trivial to implement and maintain robust, idiomatic client libraries
for many programming languages, but these can also be very helpful for
developers who want to use your API, especially the **newcomer**. The single
biggest mistake I see made with client libraries is treating them like a feature
checkbox that can be thrown out in an afternoon of coding. Very often, client
libraries in languages not native to the API developers themselves are
non-idiomatic, poorly written and actually work against developers who would
otherwise use them. If you make great clients, though, you can reduce the number
of developers in **debugger** mode by simply solving most common issues in the
client itself.

Know that client libraries for your API are very helpful, but also that they are
a long-term investment of time and resources. One strategy is to _officially_
release a few client libraries and then link to a list of unsupported
community-built libraries for other languages, as [GitHub has done][GL]. This
may be the most practical approach to supporting the most-used languages of your
API developers while still providing some help to those using other languages.
[AWS’s Ruby client][AR] is also an excellent example of focused investment,
Ruby-centric design and good handling of edge cases in a client library.

### Sample Client Projects

In addition to _libraries_, every set of API documentation should also provide
non-trivial sample client projects implemented in as many languages or
technologies as is feasible for the team. This means implementing the To Do List
app equivalent on your API for Chrome/Android/iOS: a real (if simple) product
making real calls to your API to accomplish its goals. This is your chance to
show off best practices for using your API, which should include things like
caching, client data storage, request retry and failure handling patterns,
specific data type parsing and computed display (e.g. formatting dates), et
cetera.

The maintenance burden for sample projects will be less than client libraries
because they will require fewer updates, but they will require the same
attention to detail and respect for the local customs and idioms of each host
language or platform. Accordingly, I recommend the following allocation: if you
are a team of one, implement sample projects in 1–3 languages/platforms; if your
team numbers between 2 and 6, implement 3–6 sample projects; larger teams are
severely undervaluing their developers if they don’t implement a sample project
for every language popular with their API users.

The **newcomer** can obtain a huge advantage by receiving a pre-built and tested
project in their language of choice that is already using the API. The code in
your sample projects should be unassailable and excellent, handling error cases
elegantly in addition to “happy path” responses from your API. Note that this
will also be a good opportunity to help the **debugger** by showing ideal
request & response handling, and to the **decision maker** to prove the quality
of your team’s code and your company’s service.

These sample projects may literally be the foundation of clients built in the
wild, so this is your chance to set developers on the best possible path for the
most high-quality experience with your API. This also means you should license
the code in these clients as freely as you are able — hopefully that means
[MIT][MI] or [Apache 2][AP].

### Interactivity

The most excellent API docs include the ability to make API calls directly from
the site itself. If your users can interact with your API directly from the
docs, watching how it behaves and reading explanations side-by-side, you will
greatly accelerate the ability of any developer to successfully implement a
client. Interactivity features will be very valuable to both your **newcomer**
and **debugger**, and may tip the scales on quality and
comparison-to-competition for the **decision maker**.

Adding interactivity and doing it well certainly has implications for things
like security, linkability (yes, a user’s custom code typed into your docs site
should most definitely be linkable purely via URL) and mobile friendliness. All
of these are challenges that can be overcome, but they will require putting real
talent on your team behind them.

### Concise API Overview

Addressing your **decision maker** audience head-on will be challenging, but is
completely necessary. Very often developers are not the ones making the decision
on whether to spin up a project or a team — a decision maker often makes that
call ahead of time. Showing the value of what your API provides (including what
your products actually do), how it scales (usage limits, pricing, SLAs, support)
and its limitations up front will often be the difference between a
medium-to-large business using your API or skipping past it.

### Integration with Support

When things go wrong with your API or some of your potential users get into a
tough spot, they’re going to look to your team for help. You likely already have
some support function for your API, but if not you should. When you have a
working support help desk, you should provide a persistent entry point into that
support system from your API docs site. You may also find it fruitful to clean
up and post Q&A for individual API calls or topics right inline with the
documentation, perhaps expanding if a user asks for them so as not to clutter
the basic docs.

### Live Endpoint Status

A truly unique feature that could be very useful to the **debugger** would be a
status indicator integrated with the docs for each individual endpoint. By
sampling recent API response times and response codes, perhaps normalized by
payload sizes and API keys respectively, you could show up-to-the-second status
of every endpoint in your API. This could help alleviate headaches for the
**debugger** who is trying to hit a certain endpoint and keeps getting HTTP 500
responses, or is seeing response times of 20 seconds. If it’s clear that a
significant portion of clients using that endpoint are seeing the same results,
the **debugger** is less likely to think they have done something wrong. Even
further, if your developer is logged in when viewing the documentation, you
could provide an additional status indicator for just _their_ recent calls to
each specific endpoint.

This suggestion is in direct contrast to a status page like [Twitter’s][TS] or
even [GitHub’s][GS] where errors that occur only on a single endpoint or a
subset of endpoints will often go unmentioned in a large rollup-style summary of
everything on the API. I don’t know of any API makers who provide this level of
reporting or insight into their API status. This suggestion is also entirely
[Chris Radcliff’s][CR] idea.

### Personality

All audiences are going to form an opinion of your company, your products, your
team and your API based on their visit to your API documentation site. The best
chance you have for leaving a favorable impression beyond all of the features
described above is to convey a friendly personality. Something as simple as a
small mascot, illustrations or images depicting people using your developers’
potential products can improve your memorability and reputation with **all
audiences**. Keep your prose conversational and friendly, yes, but work with
your designer to come up with something unique, just like you would for a
memorable product landing page.

Your API docs are, after all, part of your brand. Sending a message of quality,
friendliness and competence will never be more important than when you’re trying
to convince CTOs and developers to invest in your API.

## What next?

There are almost certainly more aspects of your API documentation that we could
all improve and learn from. If you think of some or have seen these things done
well, [shoot me an email](mailto:bfults@gmail.com) and I’ll happily amend this
article with credit.

_Many thanks to [Ben Hamill][BH] and [Chris Radcliff][CR] for feedback on drafts
of this article._

 [PW]: http://www.programmableweb.com/news/web-api-documentation-best-practices/2010/08/12
 [PA]: https://web.archive.org/web/20120516001257/http://blog.parse.com/2012/01/11/designing-great-api-docs/
 [SA]: https://stripe.com/docs/api
 [GI]: https://docs.github.com/en/rest/reference/issues#comments
 [SC]: https://stripe.com/docs/api/charges
 [SO]: https://stripe.com/docs/api/coupons/update
 [OA]: https://en.wikipedia.org/wiki/OAuth
 [BT]: https://developers.braintreepayments.com/ios+ruby/start/overview
 [GR]: https://docs.github.com/en/rest/overview/resources-in-the-rest-api
 [HT]: https://tools.ietf.org/html/rfc2616
 [SE]: https://stripe.com/docs/api/errors
 [CU]: https://curl.haxx.se
 [GR]: https://docs.github.com/en/rest/overview/resources-in-the-rest-api#rate-limiting
 [GL]: https://docs.github.com/en/rest/overview/libraries
 [AR]: https://docs.aws.amazon.com/sdk-for-ruby/v3/api/
 [MI]: https://en.wikipedia.org/wiki/MIT_License
 [AP]: https://www.apache.org/licenses/LICENSE-2.0
 [TS]: http://status.twitter.com
 [GS]: https://www.githubstatus.com
 [CR]: https://twitter.com/chris_radcliff
 [BH]: https://twitter.com/benhamill
