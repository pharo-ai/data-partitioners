# RandomPartitioner

This is a Pharo library for partitioning a collection. Given a set of K proportions, for example 50%, 30%, and 20%, it shuffles the collection and divides it into K non-empty subsets in such a way that every element is included in exactly one subset.

`RandomPartitioner` can be used in machine learning and statistical analysis for splitting the data into training, validation, and test (a.k.a. holdout) sets, or partitioning the data for cross-validation.

## How to install it?

To install `RandomPartitioner`, go to the Playground (Ctrl+OW) in your [Pharo](https://pharo.org/) image and execute the following Metacello script (select it and press Do-it button or Ctrl+D):

```Smalltalk
Metacello new
  baseline: 'RandomPartitioner';
  repository: 'github://olekscode/RandomPartitioner/src';
  load.
```

## How to depend on it?

If you want to add a dependency on `RandomPartitioner` to your project, include the following lines into your baseline method:

```Smalltalk
spec
  baseline: 'RandomPartitioner'
  with: [ spec repository: 'github://olekscode/RandomPartitioner/src' ].
```

If you are new to baselines and Metacello, check out this wonderful [Baselines](https://github.com/pharo-open-documentation/pharo-wiki/blob/master/General/Baselines.md) tutorial on Pharo Wiki.

## How to use it?

```Smalltalk
data := #(a b c d e f g h i j).
proportions := #(0.5 0.3 0.2).
```

```Smalltalk
partitioner := RandomPartitioner new.
subsets := partitioner split: data using: proportions.
```

```Smalltalk
#((d h j a b)
  (i f e)
  (g c))
```
