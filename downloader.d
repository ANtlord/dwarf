class GitDownloader
{
    protected const string REMOTE_FILENAME;
    protected const string NAME;
    protected const string USERNAME;
    protected const string BRANCH_NAME;

    this(const string username, const string projectName, const string branchName)
    {
        BRANCH_NAME = branchName;
        REMOTE_FILENAME = branchName~".zip";
        NAME = projectName;
        USERNAME = username;
    }

    void download(const string targetDir)
    {
        const string TEMPLATE_URL = "https://github.com/"~USERNAME~"/"~NAME
            ~"/archive/"~REMOTE_FILENAME;

        execute(["wget", TEMPLATE_URL]);
        execute(["unzip", REMOTE_FILENAME]);
        rename((NAME~"-"~BRANCH_NAME).dup, targetDir);
        remove(REMOTE_FILENAME);
    }
}
