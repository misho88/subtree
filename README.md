# subtree
manipulate text which is laid out as a tree

# requirements and installation

Needs Python 3.8+ (or so).

Either run `# make install` or put the script in your path manually.

# examples

Make a lazily drawn tree from another program look pretty:

```
$ echo -e 'a\n b\n  c\n  d\n e\nf'
a
 b
  c
  d
 e
f
$ echo -e 'a\n b\n  c\n  d\n e\nf' | subtree --pretty  # or -p
a
├── b
│   ├── c
│   └── d
└── e
f
$ echo -e 'a\n b\n  c\n  d\n e\nf' | subtree --pretty --show-root  # or -ps

├── a
│   ├── b
│   │   ├── c
│   │   └── d
│   └── e
└── f
$ echo -e 'a\n b\n  c\n  d\n e\nf' | subtree --theme rounded 0 0  # subtree by index codes with rounded ends
b
├── c
╰── d
$ echo -e 'a\n b\n  c\n  d\n e\nf' | subtree --theme tab a b  # subtree by node names with tab indentation
b
	c
	d
```

Clean up a badly drawn tree:

```
$ echo -e 'a\n    b\n  c'
a
    b
  c
$ echo -e 'a\n    b\n  c' | subtree --theme space2
a
  b
  c
```

Look around a directory hierarchy:

```
$ mkdir -p a/b/c a/b/d a/e f
$ tree
.
├── a
│   ├── b
│   │   ├── c
│   │   └── d
│   └── e
└── f

7 directories, 0 files
$ tree | subtree --indices # or -i
  0   .
  0   0   a
  0   0   0   b
  0   0   0   0   c
  0   0   0   1   d
  0   0   1   e
  0   1   f
  1
  2   7 directories, 0 files
$ tree | subtree 0 0  # subtree by index
a
├── b
│   ├── c
│   └── d
└── e
$ tree | subtree . a  # subtree by node name
a
├── b
│   ├── c
│   └── d
└── e
```

Look around a directory hierarchy with `find`:

```
$ mkdir -p a/b/c a/b/d a/e f
$ find .
.
./a
./a/e
./a/b
./a/b/c
./a/b/d
./f
$ find . | subtree --pretty --after --last --regex /  # or -palr/
.
├── a
│   ├── e
│   └── b
│       ├── c
│       └── d
└── f
$ find . | subtree --indices --after --last --regex /  # or -ialr/
  0   .
  0   0   a
  0   0   0   e
  0   0   1   b
  0   0   1   0   c
  0   0   1   1   d
  0   1   f
$ find . | subtree -alr/ 0 0  # navigate subtree using the same theme as the input
a
a/e
a/b
a/b/c
a/b/d
```

Turn a tree into JSON. The leaves are strings `""`, the remaining nodes are objects of the form `{ "name": [array of children] }`, and the root node may just be the array `[]`, depending on whether it is shown or hidden (use `--show-root` and `--hide-root` to force a specific behavior):

```
$ mkdir -p a/b/c a/b/d a/e f
$ tree | subtree --json 0  # or -j 0; JSON is very simplistic, so maybe pipe to jq or something
{".":[{"a":[{"b":["c","d"]},"e"]},"f"]}
$ tree | subtree -j 0 | python -c 'import sys, json, pprint; pprint.pprint(json.load(sys.stdin), width=1)'
{'.': [{'a': [{'b': ['c',
                     'd']},
              'e']},
       'f']}
```
