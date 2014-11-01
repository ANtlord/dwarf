import mustache;
import std.file;
alias std.file.write fwrite;
alias MustacheEngine!(string) Mustache;

class OgreProjectBuilder
{
    protected const string APP_NAME;
    this(const string appName)
    {
        APP_NAME = appName;
    }

    void setupProject()
    {
        Mustache mustache;
        auto context = new Mustache.Context;
        context["app_name"] = APP_NAME;

        string data = mustache.render(APP_NAME~"/src/TutorialApplication.cpp",
                context);
        string filename = (APP_NAME~"/src/"~APP_NAME~".cpp");
        fwrite(filename.dup, data);
        remove(APP_NAME~"/src/TutorialApplication.cpp.mustache");

        data = mustache.render(APP_NAME~"/include/TutorialApplication.h",
                context);
        filename = (APP_NAME~"/include/"~APP_NAME~".h");
        fwrite(filename.dup, data);
        remove(APP_NAME~"/include/TutorialApplication.h.mustache");

        data = mustache.render(APP_NAME~"/CMakeLists.txt",
                context);
        filename = (APP_NAME~"/CMakeLists.txt");
        fwrite(filename.dup, data);
        remove(APP_NAME~"/CMakeLists.txt.mustache");
    }
}
