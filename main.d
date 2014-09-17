//          Copyright antlord 2014.
// Distributed under the Boost Software License, Version 1.0.
//    (See accompanying file LICENSE_1_0.txt or copy at
//          http://www.boost.org/LICENSE_1_0.txt)

module main;

import std.stdio;
import std.string;
import std.stream;
import std.file;
import std.process;
import mustache;
alias std.file.write fwrite;

alias MustacheEngine!(string) Mustache;

void main(string[] args){
    if(args.length > 1)
    {
        const string NAME = "ogre-project-template";
        const string REMOTE_FILENAME = "master.zip";
        const string TEMPLATE_URL = "https://github.com/ANtlord/"~NAME
            ~"/archive/"~REMOTE_FILENAME;
        const string DIRECTORY_PATH = getcwd();

        execute(["wget", TEMPLATE_URL]);
        execute(["unzip", REMOTE_FILENAME]);
        rename((NAME~"-master").dup, args[1].dup);
        remove(REMOTE_FILENAME);


        Mustache mustache;
        auto context = new Mustache.Context;
        context["app_name"] = args[1];

        string data = mustache.render(args[1]~"/src/TutorialApplication.cpp",
                context);
        string filename = (args[1]~"/src/"~args[1]~".cpp");
        fwrite(filename.dup, data);
        remove(args[1]~"/src/TutorialApplication.cpp.mustache");

        data = mustache.render(args[1]~"/include/TutorialApplication.h",
                context);
        filename = (args[1]~"/include/"~args[1]~".h");
        fwrite(filename.dup, data);
        remove(args[1]~"/include/TutorialApplication.h.mustache");

        data = mustache.render(args[1]~"/CMakeLists.txt",
                context);
        filename = (args[1]~"/CMakeLists.txt");
        fwrite(filename.dup, data);
        remove(args[1]~"/CMakeLists.txt.mustache");
    }
    else {
        writeln("You haven't pointed appclication name");
    }
}
