# amboso-template

## Template repo for an amboso project. 

This template repo is ready to use with amboso in git mode.
The main limitation is the fact that by choosing a tag folder not named `bin/`, we are forced to pass `-D` argument to resolve the `stego.lock` file and its info.

### -D flag

I included a lazy script to wrap this problem, so you don't have to type that parameter, take a look at `anwrap`.
It's just calling the symlink `anvil` but always including the needed `-D` flag.

I also made it ready to try the backtrace but I don't think there's much to see. Still, you have the option in the `anwrap` script.

## Tool support

I should mention that the template assumes a C project.
Since at the moment the `amboso` submodule only does `make` on the build step, we are generally limited by what you can script with a Makefile (as long as at the end `make` gives the needed executable). 

You could very easily have`amboso` run some other build step, it's basically a glorified option select. SO let's say that we virtually support the whole world, and we're about to offer dependencies to Cargo, basically.

#### Useful commands for managing submodules

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

## anvil & anwrap -> amboso/amboso

`anvil` is a symlink to `amboso/amboso`. It's expected to have one in the root dir for correct behaviour.

There are a couple of tests (copied from the main repo and adapted) that you can run immediately with `./anwrap -t`.

Again, you can try to run `anvil` and you will see that it will complain about no `./bin/` directory being present.

That value is hardcoded for now but this will change soon,  allowing other default names maybe.
