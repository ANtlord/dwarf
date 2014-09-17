//          Copyright antlord 2014.
// Distributed under the Boost Software License, Version 1.0.
//    (See accompanying file LICENSE_1_0.txt or copy at
//          http://www.boost.org/LICENSE_1_0.txt)

module main;

import std.stdio;
import std.string;
import std.stream;
import mustache;
alias std.file.write fwrite;
alias MustacheEngine!(string) Mustache;

void main(string[] args){
    if(args.length > 1)
    {
        Mustache mustache;
        auto context = new Mustache.Context;
        context["app_name"] = args[1];
        string data = mustache.render("TutorialApplication", context);
        string filename = (args[1]~".cpp");
        char[] FILENAME = filename.dup;
        fwrite(FILENAME, data);
    }
    else {
        writeln("You haven't pointed appclication name");
    }
}
