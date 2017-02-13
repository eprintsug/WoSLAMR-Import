# Web of Science Links Article Match Retrieval Service configuration
#
$c->{woslamr} = {};

$c->{woslamr}->{app_id} = 'Enter the id of your app (e.g. www.repo.institution.com) here';
$c->{woslamr}->{env_id} = 'EPrints';
$c->{woslamr}->{partner_email} = 'Enter the WOS LAMR partner id here';

# field names for DOI and PubMed ID (may be different in other repositories)
#
$c->{woslamr}->{doi} = "doi";
$c->{woslamr}->{pmid} = "pubmedid";

