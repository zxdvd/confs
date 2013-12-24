Instruction
===========
This script is written for deploying puppet.
After applying the script, you will got an openQA environment same as me.
You need not to install apache2, to modify Makefile and so on.
You need not to **iso_new**.
* How to?
    * Install puppet. __zypper in puppet__
    * You need to change variables in the site.pp to adapt your environment.
    * __puppet apply site.pp__
    + List openqa jobs.  **rpc.pl --host localhost list_jobs**
    + Start a job.  **rpc.pl --host localhost job_restart 1**    
* Q&A?
    *------
    *------
