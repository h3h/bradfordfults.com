---
layout: post
title: Calibrating People Ratings on Software Teams
lang: en
---

In modern software companies, there is a well-known procedure for managers to
rate members of their team, often along to two dimensions: _performance_ and
_potential_. There is a related conceptual tool called a “9-box” that maps 3
levels (_Low_, _Medium_, _High_) onto each of these two axes, yielding 9
squares.

<style type="text/css">
table.three-box {
  border-collapse: collapse;
  display: flex;
  justify-content: center;
  margin-left: -2rem;
  text-align: center;
}
table.three-box th.vertical:not(.outer) {
  border-right-color: #666;
}
table.three-box th.vertical > p {
  margin-left: 0;
  text-orientation: mixed;
  writing-mode: vertical-rl;
}
table.three-box th.outer {
  color: #999;
}
table.three-box td:not([colspan]) {
  border: 1px solid #666;
}
</style>

<table class="three-box">
  <tr>
    <th class="outer vertical" rowspan="3"><p>Performance</p></th>
    <th class="vertical"><p>High</p></th>
    <td>Box 3</td>
    <td>Box 2</td>
    <td>Box 1</td>
  </tr>
  <tr>
    <th class="vertical"><p>Medium</p></th>
    <td>Box 6</td>
    <td>Box 5</td>
    <td>Box 4</td>
  </tr>
  <tr>
    <th class="vertical"><p>Low</p></th>
    <td>Box 9</td>
    <td>Box 8</td>
    <td>Box 7</td>
  </tr>
  <tr>
    <td colspan="2"></td>
    <th>Low</th>
    <th>Medium</th>
    <th>High</th>
  </tr>
  <tr>
    <td colspan="2"></td>
    <th class="outer" colspan="3">Potential</th>
  </tr>
</table>

* As much as possible, the person independent from their current team/project/role

An unmentioned third dimension that usually factors into this activity is the
_job level_ of the person in question: are they a technical contributor who has
achieved Senior, Staff, or Principal; or are they a Manager, Senior Manager, or
Director? The person’s job level should inform their managers of the
_expectations_ for that role, and thus also set the bar for performance and
potential.

The first challenge that managers often run into is: _What does it mean_ for
someone to have low, medium or high potential? Performance is usualy a bit more
straightforward: either the person is performing in line with expectations,
significantly above expectations, or below expectations.
