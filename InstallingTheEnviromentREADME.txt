Installing VSCode
    Step 1
        Start by downloading the VSCode (free)
            link:
            https://code.visualstudio.com/docs
        and install it, using any settings you see fit. (I used the recommended ones for most of the installation)
            For more on VSCode please go to: https://code.visualstudio.com/docs

    Step 2
        Just search for "Clinical Quality Language" in the marketplace and install the extension. It'll be activated once you open a .cql file.
        link: https://marketplace.visualstudio.com/items?itemName=cqframework.cql
        Click on install the CQL framework.

    Step 3
        Go to your machine and create a folder (I named mine CQL project) and create a .cql file.
        Then use VSCode to open it and the extension will be active. It requires java to be installed and it might prompt you to install Java if you do not have it.

USING GITHUB
    Push code to GitHub link with instructions and pictures: https://techobservatory.com/how-to-push-code-from-visual-studio-code-to-github/#step-1-create-a-github-repository
    Step 1: Create A GitHub Repository
        Once your repository is created, copy the web URL. This URL allows us to push code to this repository from VS Code.

    Step 2: Open An Existing Project With VS Code
        From the “Explorers” tab in the sidebar, click on the Open Folder button.
        Open the folder from your preferred directory and make sure all the code files are in one folder, as you’ll have to push your folder to GitHub.

    Step 3: Commit The Code Files
        Note: Make sure you configure your 'user.email' and 'user.name' in git" when trying to push to git. link: http://vcloud-lab.com/entries/powershell/solved-visual-studio-code-make-sure-you-configure-your-user-name-and-user-email-in-git
            cd C:\Program Files\Git\bin
            git config --global user.email "you@example.com"
            git config --global user.name "Your Name"
            git config -l --show-origin

    Step 4: Push Code From Visual Studio Code To GitHub
