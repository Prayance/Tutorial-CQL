If you want to use VSCode, please follow:

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

        Click on the Initialize Repository button from the “Source Control” tab in the sidebar.
        Now, under the Source Control panel, enter any commit message. I’m going to type “First Commit.” 
        Then, click on the ✓ icon next to Source Control heading or press Ctrl + Enter.
        Click Yes on the prompt pop-up.

        There may be a case that you receive a message saying something along the lines of: "Make sure you configure your 'user.email' and 'user.name' in git"
        If so please follow these additional steps: link: http://vcloud-lab.com/entries/powershell/solved-visual-studio-code-make-sure-you-configure-your-user-name-and-user-email-in-git
            in your command prompt navigate to the bin directory of you Git usually is: 
                cd C:\Program Files\Git\bin
            Now type your email and name like:
                git config --global user.email "you@example.com"
                git config --global user.name "Your Name"
            You can check if those are set by going into your repository, and typing:
                git config -l --show-origin

    Step 4: Push Code From Visual Studio Code To GitHub
        Inside the Source Control panel, click on the three-dot (ellipsis) icon. Select Pull, Push option from the list of options and then select "Push to" option.
        On the right corner, you will be prompted to add a remote. Click on Add Remote button.
        Next, on the top-center, a palette will appear. Paste the copied GitHub repository URL and press Enter.
        Then, type any remote name and press Enter. I typed "First Remote"
        Open the Push to sub-menu option again. Then, choose your repository path and press Enter.
        A pop-up will appear to log in to GitHub. Choose which option you’ll use to sign – I’m using my browser.
        An authorization page will pop up in the browser. Click on the GitCredentialManager button.
        Enter your GitHub credentials
        Finally, refresh your GitHub repository URL and you will notice that the codes are successfully pushed to GitHub from your local repository.