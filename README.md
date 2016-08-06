# GamBall #

Do you have your faith on your balls? Put your money in!

### Where to play? ###

I've deployed two versions on my website:

[GamBall -- Release Version](http://rolloliu.com/gamball/)

[GamBall -- Debug Version (can use debug keys aka. cheating keys)](http://rolloliu.com/gamball-debug/)

### How to Set Up ###

1. Download and install [Node JS](https://nodejs.org);
2. Download and install [Haxe 3.2.1](https://haxe.org/download/version/3.2.1/);
3. Locate your repo folder. Make sure you are **UNDER the repo root**;
4. Run `npm install` -- it will install all the grunt dependencies;
5. Run `npm install -g grunt-cli` -- it will install the grunt command line for your machine (global install);
6. Run `haxelib install build_debug.hxml` -- it will install all the dependency Haxe libraries.
7. Run `grunt` -- debug auto build;
8. Run `grunt release` -- make a release build.

### Debug Keys ###

 * "]" -- Toogle step by step physics.
 * "[" -- Next frame of the physics calculation. NOTE. It's not "step" but "frame" (we don't update graphic transforms on each step, only each frame)


### Additional Information ###

IDE: HaxeDevelop, Visual Studio Code

Softwares: Photoshop, Git BASH, TortoiseGit