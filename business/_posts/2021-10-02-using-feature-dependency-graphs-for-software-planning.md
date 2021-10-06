---
title: Using Feature Dependency Graphs for Software Planning
layout: post
---

When developing software systems there is a very common need among all of the
stakeholders involved: to know *how we get from where we are today to some
particular result*. In software product management, the result would be a
“deliverable” or a “feature” that provides real, tangible value to customers or
clients.

## The Problem: A Planner–Creator Gap
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

<div class="svg" style="padding-bottom: 98pt">
  {% include fdg_example.svg %}
</div>

That’s really it, but the value is in the details of how the nodes are
conceptualized and organized, and how the graph is used as a part of the team’s
process.

### How to use feature dependency graphs

Typically, product managers would identify a problem that they would like to
solve for customers, they would do research, discuss potential solutions with
software engineers, and write product requirements based on a chosen solution
path. From those requirements, user stories would be written, often as tasks
within a project (or Stories within an Epic). Then, the product manager just
sort of waits around until the engineers have altered the software enough for
the user stories to be implemented.

Using feature dependency graphs, this method changes a bit: after product
managers do customer research and understand the problem, they discuss potential
solution paths with engineers, those engineers go do research of their own on
the potential changes to the code and systems impacted, and *those solution
paths are made explicit, as feature dependency graphs.*

The product manager and engineers get together to literally draw the different
implementation paths that solutions could take, with each engineering task as a
green bubble, and the customer value as a blue square at the end. There is an
immediate benefit to this shared understanding of the implementation path:
product managers can identify more expensive paths and ask whether the desired
feature is worth the investment, or whether a different solution to the
customer’s problem might be wiser.

#### Building a roadmap with dependency graphs

There is another method of using dependency graphs that is above the level of
one feature: building a roadmap for a team.

Instead of representing a roadmap as a list of epics or projects, or worse—a
Gantt chart full of dates that are lies—you can build your roadmap as a graph
of projects that are meant to lead to some ultimate customer value, e.g.
achieving some measurable *key result* in an OKR framework.

By defining and refining the roadmap as a graph, product managers and engineers
are both again sharing a close understanding of the steps require to get from
where the software is today to where they would like it to be in the future.
Instead of a project manager incessantly updating estimated project completion
dates or cascading dependencies that almost always hide most of the necessary
engineering work, the engineers and product manager can look at and change the
path that the team will follow, understanding clearly the relationship between
the work being completed today and the ultimate goal of delivering several
projects to achieve a larger goal.

### Pitfalls and tips for using dependency graphs

As with any method for working, using dependency graphs for either feature
planning or roadmapping requires practice and refinement along the way. Some
key points to watch out for when using them:

* Ensure that engineers and the product manager are explaining and understanding
  every bubble and box on the graph: how complex the work is, what each
  intermediate goal looks like, and whether there are ways to change the scope
  of the work or the deliverable.
* Ensure that each bubble on the graph is at roughly the same level of
  granularity: you want each task within a project to be addressing challenges
  at a similar scale, and not straying off into the details.
* 


 [AS]: https://en.wikipedia.org/wiki/Agile_software_development
 [SA]: https://www.scaledagileframework.com
 [DT]: https://www.scaledagileframework.com/design-thinking/
 [DA]: https://en.wikipedia.org/wiki/Directed_acyclic_graph
