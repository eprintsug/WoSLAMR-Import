
######################################################################

=item $xhtmlfragment = eprint_render( $eprint, $session, $preview )

This subroutine takes an eprint object and renders the XHTML view
of this eprint for public viewing.

Takes two arguments: the L<$eprint|EPrints::DataObj::EPrint> to render and the current L<$session|EPrints::Session>.

Returns three XHTML DOM fragments (see L<EPrints::XML>): C<$page>, C<$title>, (and optionally) C<$links>.

If $preview is true then this is only being shown as a preview.
(This is used to stop the "edit eprint" link appearing when it makes
no sense.)

=cut

######################################################################

$c->{eprint_render} = sub
{
	my( $eprint, $session, $preview ) = @_;

	my( $page, $p, $a );

	# UZH CHANGE 02/11/2015 jv, ZORA-440: 2-Spaltig
	my $e2_column = $session->make_element( "div", id=>"e2_column", class=>"col-lg-12 col-md-12 col-sm-12 col-xs-12 summary-widget");

	my $e2_column_left = $session->make_element( "div", class=>"col-md-8 e2_column_left");
	my $e2_column_right = $session->make_element( "div", class=>"col-md-4 e2_column_right");

	$e2_column->appendChild( $e2_column_left );
	$e2_column->appendChild( $e2_column_right );

	$page = $session->make_doc_fragment;

	# UZH CHANGE 2014/09/25/mb, 2014/10/09/mb statistics section
	# UZH CHANGE 2015/12/07/jv ZORA-440: change table to floating divs

 	my $statistics_clearfix_div = $session->make_element( "div", class=>"statistics-clearfix-div");
 	my $statistics_inner_div = $session->make_element( "div", class=>"statistics-inner-div");
		
	# Citations column
	my $do_citation_row = 0;
	my $citation_frag_wos;
	
	($citation_frag_wos, $do_citation_row) = make_wos ($session, $eprint, $do_citation_row);
	
	if ($do_citation_row == 1) 
	{
 		my $statistics_floating_div = $session->make_element( "div", class=>"statistics-floating-div", id=>"stat_citation");
		my $citations_title = $session->make_element( "h2" );
		$citations_title->appendChild( $session->html_phrase( "page:citations_title" ) );
		$statistics_floating_div->appendChild( $citations_title );
	
		my $citations_div = $session->make_element( "div");
		$citations_div->appendChild( $citation_frag_wos );
		$citations_div->appendChild( $citation_frag_scopus );
		$citations_div->appendChild( $citation_frag_gscholar );
	
		$statistics_floating_div->appendChild( $citations_div );
		$statistics_inner_div->appendChild( $statistics_floating_div );
	}
	
	$statistics_clearfix_div->appendChild( $statistics_inner_div );
	$e2_column_left->appendChild( $statistics_clearfix_div );

	my $title = $eprint->render_description();

	my $links = $session->make_doc_fragment();
	$links->appendChild( $session->plugin( "Export::Simple" )->dataobj_to_html_header( $eprint ) );
	$links->appendChild( $session->plugin( "Export::DC" )->dataobj_to_html_header( $eprint ) );

	return( $page, $title, $links );
};

# UZH CHANGE 2014/09/26/mb create Web of Science citation count
sub make_wos
{
	my ( $session, $eprint, $do_citation_row ) = @_;

	my $frag = $session->make_doc_fragment();
	
	if ( $eprint->is_set("woslamr_source_url") && not( $eprint->is_set("no_citation_data_from_wos") && ( $eprint->get_value("no_citation_data_from_wos") eq "TRUE" )))
	{
		my $wos_src_url = $session->make_element(
			"a",
			href => $eprint->get_value("woslamr_source_url"),
			target => "_blank"
		);
		$wos_src_url->appendChild( $session->html_phrase( "wos" ) );
		 	
		if ($eprint->is_set( "woslamr_times_cited" ) && $eprint->get_value( "woslamr_times_cited" ) > 0 )
		{
			my $citation_count = $eprint->get_value( "woslamr_times_cited" );
			$frag->appendChild( $session->make_text( $citation_count ) );
			$frag->appendChild( $session->make_text( " " ) );
			if ( $citation_count == 1) 
			{
				$frag->appendChild( $session->html_phrase( "page:times_cited_1" ) );
			}
			else
			{
				$frag->appendChild( $session->html_phrase( "page:times_cited_n" ) );
			}
			$frag->appendChild( $session->make_text( " " ) );
		}
		$frag->appendChild($wos_src_url);
		$do_citation_row = 1;
	}
	
	return ( $frag, $do_citation_row );
}


