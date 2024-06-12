+++
title = "Visualizing Nested Data with Recursive Vue.js Components"
date = 2024-06-10
draft = true
description = "Using recursive Vue.js components to build a Table of Contents and a file tree."

[taxonomies]
tags = ['javascript', 'vuejs']
+++

{{ toc() }}

You can build some awesome UI components by mixing recursion and
Vue.js.

{{ post_figure(path="treeview-1.png", alt="A file tree made with a recursive
Vue.js component.", caption="A file tree. Each node is a recursive Vue
component.") }}

Recursion is one of those things that I learned in school but don't use all that
often in the real life. One great use for it, however, is for building trees
with data that's already in a recursive format.

<details>
<summary>Click to read more about recursion</summary>

A recursive function is a function that calls itself during its execution. It
solves a problem by chopping it up into series of smaller sub-problems, as
illustrated in the example below. The `sum` function adds up integers in an
array by calling itself with ever smaller subsets of the array. No loops to be
found.

<figure class="post-figure">

```js
function sum(arr) {
  // BASE CASE
  if (arr.length === 0) {
    return 0;
  }
  // GENERAL (RECURSIVE) CASE
  return arr[0] + sum(arr.slice(1));
}

sum([1, 2, 3, 4]); // The result is 10.
```

</figure>

The **base case** is the condition that stops recursion. Without a base case
we'd have an infinite loop resulting in a stack overflow. In our example,
recursion stops when `sum` has been called with an empty array.

In the **general case**, or recursive case, the function calls itself with a
subset of the original array. Let's visualize how the program handles each frame
by indenting each recursive call and outdenting each return. Once it reaches the
base case, we head back to the top of the stack.

```txt
sum([1, 2, 3, 4])         // Initial call
  1 + sum([2, 3, 4])      // General case
      2 + sum([3, 4])     // General case
          3 + sum([4])    // General case
              4 + sum([]) // General case
                  0       // Reached the base case
              4 + 0
          3 + 4
      2 + 7
  1 + 9
10
```

</details>

## Recursive Vue Components

A recursive Vue.js component is a component that references itself. Just like
recursive functions, we can use recursive Vue components to elegantly process
data.

### Example 1 - Table of Contents

I came across a great use for recursive components while building the
[About](@/about.md) page on this site. Zola generates a nested JSON structure
for a table of contents based on the HTML headers on the page. `<h1>` at the top
level, then `<h2>`, and so on.

<details>
<summary>Click to show data.json</summary>

<figure class="post-figure">

```json
[
  {
    "title": "About Me",
    "children": [
      {
        "title": "Interests",
        "children": []
      },
      {
        "title": "Work Stuff",
        "children": []
      }
    ]
  },
  {
    "title": "About This Site",
    "children": [
      {
        "title": "Tech",
        "children": [
          {
            "title": "Performance"
          },
          {
            "title": "Sustainability"
          },
          {
            "title": "Security and Privacy"
          }
        ]
      },
      {
        "title": "Styling and Other Choices",
        "children": [
          {
            "title": "Domain Name"
          },
          {
            "title": "Favicon"
          },
          {
            "title": "Color and Font"
          }
        ]
      }
    ]
  }
]
```

</figure>
</details>

Let's display this data as an HTML list of nested lists. First we'll make a
wrapper component called `Tree.vue`.

<figure class="post-figure">
<figcaption>Tree.vue</figcaption>

```js
<script setup>
import treeData from './data.json';
import TreeNode from './TreeNode.vue';
</script>

<template>
  <ul>
    <TreeNode v-for="node in treeData" :node="node" />
  </ul>
</template>
```

</figure>

`Tree.vue` kicks off the process by creating an unordered list `<ul>` and using
the `v-for` directive to create one `TreeNode` component per top-level item in
the JSON array. The node is passed to `TreeNode` via the `node` prop.

Next, our recursive component, `TreeNode.vue`.

<figure class="post-figure">
<figcaption>TreeNode.vue</figcaption>

```js
<script setup>
import { defineProps } from 'vue';

defineProps({
  node: {
    type: Object,
    default: () => [],
  },
});
</script>

<template>
  <li>
    <span>{{ node.title }}</span>
    <ul v-if="node.children">
      <TreeNode v-for="child in node.children" :node="child" />
    </ul>
  </li>
</template>
```

</figure>

So what's happening here?

`TreeNode.vue` is essentially a list item that displays `node.title`. But now
for the exciting part -- there is also a nested unordered list just like the one
in `Tree.vue`, except this time `v-for` loops through the node's _children_ and
passes each child through the `node` prop. Notice that `TreeNode` references
itself; that is the _recursive case_. The _base case_ (which stops recursion) is
on the previous line: `<ul v-if="node.children">`. If a node has no children,
we've reached a leaf in the tree and we don't need to render the nested list.

#### What Do We Get?

A tidy table of contents tree! We get some style for free because the browser
automatically indents nested lists.

<ul><li><span>About Me</span><ul><li><span>Interests</span><ul></ul><li><span>Work Stuff</span><ul></ul></ul><li><span>About This Site</span><ul><li><span>Tech</span><ul><li><span>Performance</span><li><span>Sustainability</span><li><span>Security and Privacy</span></ul><li><span>Styling and Other Choices</span><ul><li><span>Domain Name</span><li><span>Favicon</span><li><span>Color and Font</span></ul></ul></ul>

### Example 2 - File Tree

A slightly more complicated example is a file tree. Say we have a list of nested
directories and files, and we want to show their hierarchy and expand or
collapse directories. We can use recursive components for this as well.

<details>
<summary>Click to show data.json</summary>

<figure class="post-figure">

```json
[
  {
    "name": "CourageouslyBlahWarped",
    "children": [
      {
        "name": "TelescreenMidst",
        "children": [
          {
            "name": "UnderneathFlicker",
            "children": [
              {
                "name": "veil.vsw",
                "children": []
              },
              {
                "name": "UghBusily",
                "children": [
                  {
                    "name": "PatternQueasilyBath",
                    "children": [
                      {
                        "name": "defoliate_merrily.css",
                        "children": []
                      }
                    ]
                  }
                ]
              },
              {
                "name": "brightly_following.xls",
                "children": []
              },
              {
                "name": "gymnastics_awful.mpe",
                "children": []
              }
            ]
          },
          {
            "name": "AckWarmhearted",
            "children": [
              {
                "name": "ensure_handmade_fairly.xlc",
                "children": []
              },
              {
                "name": "aboard_specific.ogx",
                "children": []
              }
            ]
          }
        ]
      }
    ]
  },
  {
    "name": "Leaf.txt"
  }
]
```

</figure>
</details>

<figure class="post-figure">
<figcaption>Tree.vue</figcaption>

```js
<script setup>
import treeData from './data.json';
import TreeNode from './TreeNode.vue';
</script>

<template>
  <div>
    <TreeNode v-for="node in treeData" :node="node" />
  </div>
</template>
```

</figure>

`Tree.vue` is similar to the first example, except the parent tag is a `<div>`
instead of a `<ul>`.

<figure class="post-figure">
<figcaption>TreeNode.vue (part 1)</figcaption>

```js
<script setup>
import { defineProps, computed } from 'vue';

const props = defineProps({
  node: {
    type: Object,
    default: () => [],
  },
});

const hasChildren = computed(() => !!props.node.children?.length);
</script>

<template>
  // RECURSIVE CASE
  <details v-if="hasChildren" class="node" open>
    <summary class="branch">
      <span class="icon"></span>
      <span class="label">{{ node.name }}</span>
    </summary>
    <TreeNode v-for="child in node.children" :node="child" />
  </details>
  // BASE CASE
  <div v-else class="node leaf" tabindex="0">
    <span class="icon"></span>
    <span class="label">{{ node.name }}</span>
  </div>
</template>
```

</figure>

Here I've used the
[`<details>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/details)
HTML element to control the visibility of child nodes. If a node has children,
the component will render a `<details>` element with a nested `TreeNode`. If the
node is a leaf, it renders a simple `<div>`.

#### A First Pass

{{ post_figure(path="treeview-2.png", alt="An unstyled file tree made with a
recursive Vue.js component.", caption="Looks pretty bad.") }}

The general structure is right, but we need to add some CSS to make this look
anything like a file tree. In Example 1 the browser automatically indented
nested lists, but we're not using lists here. If we add some left padding to
each node, the padding will stack on top of the padding of the nodes above.

<figure class="post-figure">
<figcaption>TreeNode.vue (part 2)</figcaption>

```js
<style lang="scss" scoped>
.node {
  margin-left: 3px;
  padding-left: 20px;
  border-left: 1px dotted black;
}
</style>
```

</figure>

{{ post_figure(path="treeview-3.png", alt="An properly-indented file tree made
with a recursive Vue.js component.", caption="Now it's starting to look like a
tree!") }}

Alright, let's flesh this out a bit with icons and some other finishing touches.
Add some broth, a potato... baby you got a stew going!

<figure class="post-figure">
<figcaption>TreeNode.vue (part 3)</figcaption>

```js
<style lang="scss" scoped>
.node {
  margin-left: 3px;
  padding-left: 20px;
  border-left: 1px dotted black;
  line-height: 2rem;

  .label {
    margin-left: 3px;
  }

  .icon {
    display: inline-block;
    width: 20px;
    height: 20px;
    background-repeat: no-repeat;
    background-size: contain;
    vertical-align: text-bottom;
  }

  > summary {
    cursor: pointer;
    &:hover {
      color: purple;
    }
    .icon {
      background-image: url('/src/assets/folder.ico');
    }
  }

  // Use background images to easily switch icons based on the state.
  &[open] > summary .icon {
    background-image: url('/src/assets/open-folder.ico');
  }
  &.leaf .icon {
    background-image: url('/src/assets/document.ico');
  }

  .branch,
  .leaf {
    box-sizing: border-box;
    outline: none;
    &:focus .label {
      border: 1px dotted black;
    }
  }
}

// Remove the dotted border from the top level.
.tree > .node {
  border-left: none;
}
</style>
```

</figure>
