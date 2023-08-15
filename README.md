# WoSLAMR-Import

## WoS LAMR deprecated as of November 2023

Web of Science Linked Article Match Retrieval will be deprecated as of November 2023. 
Instead, the Web of Science REST based API must be used then. 
The code in this repository below is just kept for historic reasons. 

As a replacement, the [Web of Science citation plugin (WoS REST API based)](https://github.com/eprintsug/wos/) can be used.


## Web of Science Linked Article Match Retrieval  - Import Citation Data

The WoS LAMR import script gathers citation data from Clarivate Analytics Web of Science™ 
Core Collection. It imports Times Cited, UT Number, Source URL, Citing Article URL, 
Related Records URL from Web of Science™ Core Collection via 
[Links Article Match Retrieval Service](http://wokinfo.com/directlinks/amrfaq/) (Links AMR).




## Requirements

License to Clarivate Analytics Web of Science™ Core Collection. In addition, administrators
should register an appid (e.g. the URL of their repository) and a partner e-mail address
with Clarivate.


## General setup

The setup procedure consists of the following steps

- Installation
- Configuration
- Test the import script
- Edit your cron table
- Rendering the citation data


## Installation

Copy the content of the bin and cfg directories to the respective 
{eprints_root}/archives/{yourarchive}/bin and {eprints_root}/archives/{yourarchive}/cfg 
directories.


## Configuration

### Edit the z_wos_lamr.pl file

In your cfg.d/z_wos_lamr.pl file, you need to adapt the following lines:

```perl
$c->{woslamr}->{app_id} = 'Enter the id of your app (e.g. www.repo.institution.com) here';
$c->{woslamr}->{env_id} = 'EPrints';
$c->{woslamr}->{partner_email} = 'Enter the WOS LAMR partner id here';

# field names for DOI and PubMed ID (may be different in other repositories)
#
$c->{woslamr}->{doi} = "doi";
$c->{woslamr}->{pmid} = "pubmedid";
```

### Edit the eprint_fields.pl file

Insert the field definitions from cfg.d/eprint_fields_snippet.pl into your 
cfg.d/eprint_fields.pl .



### Restart the web server

After you have edited the configuration files, restart the web server.


### Add the fields to your database

Carry out an epadmin update yourrepo to get the new fields added to your database.


### Test the import script

Test if you have a successful connection to the WoS LAMR Service by issuing a

sudo -u {web_process_name} bin/import_citation_data_from_wos_via_lamr {yourrepo} 1

Depending on your environment, you may also need to specify a http/https proxy server.


### Edit your cron table

Create a shell script that calls bin/import_citation_data_from_wos_via_lamr. 
Depending on your environment, you may also need to specify a http/https proxy server. 
Add this script to your crontab; we recommend to carry out the update job once per week. 

### Rendering the citation data

Rendering of the citation data is highly specific to how the repository was configured. 
You can add the WoS fields to your cfg/citations/eprint/summary_page.xml. Others (as we 
do at UZH) use a tailored cfg.d/eprint_render.pl to render the summary page. We provide
a snippet in cfg.d/eprint_render_snippet.pl that you can take as an example for your repo.
