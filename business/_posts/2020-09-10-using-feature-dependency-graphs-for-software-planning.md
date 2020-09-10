---
title: Using Feature Dependency Graphs for Software Planning
layout: post
---

When developing software systems there is a very common need among all of the
stakeholders involved: to know *how we get from where we are today to some
particular result*. In software product management, the result would be a
“deliverable” or a “feature” that provides real, tangible value to customers or
clients.

## The Problem: An Engineering/Non-Engineering Gap
[Agile software development][AS] and other process frameworks for managing
enterprise-level complexity like [SAFe][SA] have concepts that address many
facets of software creation, but there is an implied barrier built into all of
these processes: between software engineers on the one side, and product
managers, business leaders, customer support, project managers, marketing, and
other functions involved in getting working software to customers on the other
side.

It is assumed within processes like *[Design Thinking][DT]* that newly
discovered hypotheses in need of testing and implementation can just be
*implemented*, almost as an after-thought to the hard work of ideation. But as
software engineers everywhere know, the *path of change* necessary to implement
any particular ability or to achieve any particular result in a software system
is often complex. Between the lofty list of customer stories and shiny features
to be built, there is a gap of understanding between the non-engineers in the
room and the engineers who see the tangled mess of the journey necessary to
realize those results.

Misunderstandings and misalignments abound on teams from this gap, including
things like time estimates (“How can it possibly take 3 weeks to change a web
form?”), a product manager’s effort investment (“I have to worry about talking
to more customers; the engineers will figure out how to implement.”), and
ultimately feature development ROI (“Is it worth it to build this ability into
the system, given the proposed benefit to the customer?”).

Shared understanding almost always increases the effectiveness of collaboration
between any two people or groups, and the method described below aims to reduce
the gap between these groups, and to increase shared understanding for the
creation of better software systems through a journey more enjoyable, efficient
and effective for everyone involved.

## One Possible Solution: Feature Dependency Graphs
One of my excellent former teams at Under Armour and I developed a technique to
aid cross-functional planning for their software systems. We created a method
and an artifact to share knowledge and create understanding around the necessary
*path of change* to achieve results for their products and systems. Instead of
trying to informally or implicitly link together several projects (or “Epics” in
Agile parlance), usually by explaining over and over again what will be
necessary to actually change in the software systems in question, they
re-centered their team’s planning and development process around a concrete
artifact: a feature dependency graph (FDG).

### What are feature dependency graphs?
In a technical sense, they are directed acyclic graphs ([DAGs][DA]) that have
two different types of nodes: (a) project nodes, each of which captures work
that must be done to some specific part of the software system in question, and
(b) deliverable nodes, or abilities that the software system will have after the
preceding projects have been completed. For example:

<img alt="Example FDG" src="/img/fdg-example.svg" />

That’s really it, but the value is in the details of how the nodes are
conceptualized and organized, and how the graph is used as a part of the team’s
process.

### How to use feature dependency graphs


### Pitfalls and tips for using feature dependency graphs

 [AS]: https://en.wikipedia.org/wiki/Agile_software_development
 [SA]: https://www.scaledagileframework.com
 [DT]: https://www.scaledagileframework.com/design-thinking/
 [DA]: https://en.wikipedia.org/wiki/Directed_acyclic_graph
