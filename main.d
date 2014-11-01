module main;

import std.stdio;
import std.string;
import std.stream;
import std.process;
import GitDownloader;
import OgreProjectBuilder;

void main(string[] args){
    if(args.length > 1)
    {
        auto templateDownloader = new GitDownloader("ANtlord",
                "ogre-project-template", "master");
        templateDownloader.download(args[1].dup);

        auto builder = new OgreProjectBuilder(args[1]);
        builder.setupProject();
    }
    else {
        writeln("You haven't pointed appclication name");
    }
}
