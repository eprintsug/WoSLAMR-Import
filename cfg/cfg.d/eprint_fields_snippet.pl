#ZORA-196 (ARTICLE MATCH RETRIEVAL FROM WEB OF SCIENCE)
        {
                'name' => 'woslamr_times_cited',
                'type' => 'int',
                'volatile' => 1,
        },

        {
                'name' => 'woslamr_cluster',
                'type' => 'text',
                'volatile' => 1,
        },
   
        {
               'name' => 'woslamr_source_url',
               'type' => 'url',
               'volatile' => 1,
        },

        {
               'name' => 'woslamr_citing_articles_url',
               'type' => 'url',
               'volatile' => 1,
        },

        {
               'name' => 'woslamr_related_records_url',
               'type' => 'url',
               'volatile' => 1,
        },

        {
               'name' => 'no_citation_data_from_wos',
               'type' => 'boolean',
               'input_style' => 'checkbox',
               'volatile' => 1,
        },
#END ZORA-196 (ARTICLE MATCH RETRIEVAL FROM WEB OF SCIENCE)
