# amboso-template

# Note

## This repo is for an out of date version of `amboso`.

After `2.x`, `amboso` can prepare a new project with `init` subcommand.

This template will stay as is in order to help older `amboso` versions to be used with a new project, if ever needed.

A new branch named `v2` or something similare may be added at a later time to actually update this template, and it may be changed to be the default branch in the future.

## Table of Contents <a name = "index"></a>

+ [What is this thing?](#witt)
  + [The -D flag](#dirflag)
  + [Submodules](#submodules)
  + [Autoreconf and ./configure](#autotools)
  + [./anvil and ./anwrap](#anvil_anwrap)

## What is this thing? <a name = "witt"></a>

This is a template repo ready to use with [amboso](https://github.com/jgabaut/amboso) in git mode.
The main limitation is the fact that by choosing a tag folder not named `bin/`, we are forced to pass `-D` argument to resolve the `stego.lock` file and its info.


### -D flag <a name = "dirflag"></a>

I included a lazy script to wrap [this problem](https://github.com/jgabaut/amboso#note-2), so you don't have to type that parameter, take a look at `anwrap`.
It's just calling the symlink `anvil` but always including the needed `-D` flag.

I also made it ready to try the backtrace but I don't think there's much to see. Still, you have the option in the `anwrap` script.

## Tool support <a name = "toolsupport"></a>

I should mention that the template assumes a C project.
Since at the moment the `amboso` submodule only does `make` on the build step, we are generally limited by what you can script with a Makefile (as long as at the end `make` gives the needed executable).

You could very easily have`amboso` run some other build step, it's basically a glorified option select. SO let's say that we virtually support the whole world, and we're about to offer dependencies to Cargo, basically.

## Useful commands for managing submodules <a name = "submodules"></a>

`amboso` was added as a submodule, the script is found at `amboso`/`amboso`.

- Go back to state checked in for current template commit:

```
  git submodule update --init
```
- Pull updates from amboso repo and dirty your current template index:  (you may then need to commit or restore those changes, when you want to use git mode)

```
git submodule update --remote
  # You can clean a dirty submodule by doing init again and/or git restore as needed.
```

I don't think you can use git mode when the repo is not in a clean state, and having a newer version of amboso you haven't committed wouldn't be kosher.

### Autoreconf and ./configure <a name = "autotools"></a>

  You may need to run `automake --add-missing` to ensure your system provides the missing files needed by `autoreconf`.

  Run `autoreconf` to generate the `./configure` script. Run the script to generate the `Makefile` used for the project.

## anvil & anwrap -> amboso/amboso <a name = "anvil_anwrap"></a>

`anvil` is a symlink to `amboso/amboso`. It's expected to have one in the root dir for correct behaviour.

There are a couple of tests (copied from the main repo and adapted) that you can run immediately with `./anwrap -t`.

Again, you can try to run `anvil` and you will see that it will complain about no `./bin/` directory being present.

That value is hardcoded for now but this will change soon,  allowing other default names maybe.
