#!/usr/bin/perl -w

use strict;
use CGI qw(:standard :html3);
use DBI();
use lib "/home/thomas/perl/lib/perl/5.10.0/";
use frbr;
use Tie::IxHash;
use HTML::Template;
my $tmpl = HTML::Template->new(filename => 'frbr.tmpl', debug => 1);

# global variant
my @Entry_G1 = qw(work expression manifestation item);	# right/left
my @Entry_G2 = qw(person corporate_body);		# down
my @Entry_G3 = qw(concept object event place);		# up
my @Entry = [@Entry_G1, @Entry_G2, @Entry_G3];
my $current_entry = param('entry');
$current_entry = 'work' if (param('entry') eq '');

# CMD include 'create || insert || edit || delete || browse(default)'
my $CMD = param('CMD');
$CMD = 'browse' if (param('CMD') eq '');

# RT_CMD include 'add || delete || NONE'
my $RT_CMD = param('RT_CMD');
$RT_CMD = 'NONE' if (param('RT_CMD') eq '');

my %entry;
my $t = tie(%entry, 'Tie::IxHash');

my %db_entry_map = (
    'work'              => 'Work_Attrs',
    'expression'        => 'Expression_Attrs',
    'manifestation'     => 'Manifestation_Attrs',
    'item'              => 'Item_Attrs',
    'person'            => 'Person_Attrs',
    'corporate_body'    => 'Corporate_body_Attrs',
    'concept'           => 'Concept_Attrs',
    'object'            => 'Object_Attrs',
    'event'             => 'Event_Attrs',
    'place'             => 'Place_Attrs'
);
my $id = param('ID');
$id = 'MAX' if (param('ID') eq '');
$tmpl->param(ID => $id);

# Functions #

# get_table_relation_type
sub get_entry_relation_type {
    my $entry = $_[0];

    my %entry_type;
    my %rt = get_relation_type();
    foreach my $type (keys(%rt)){
	if ($type =~ /$current_entry/i){
	    @{$entry_type{$type}} = @{$rt{$type}};
	}
    }
    return %entry_type;
}

# get desc for relation type
sub get_left_relation_type_desc {
    my $check_type = $_[0]; ## relation type

    my %type_desc = get_relation_type_desc();
    foreach my $type (keys(%type_desc)){
	if ($type eq $check_type){
	    return $type_desc{$type}[0];
	}
    }
}

sub get_right_relation_type_desc {
    my $check_type = $_[0]; ## relation type

    my %type_desc = get_relation_type_desc();
    foreach my $type (keys(%type_desc)){
	if ($type eq $check_type){
	    return $type_desc{$type}[1];
	}
    }
}

# filter left relationship
sub get_left_relation {
    my $entry = $_[0];
    my ($left, $right) = split('-', $entry);
    return $left;
}
sub get_right_relation {
    my $entry = $_[0];
    my ($left, $right) = split('-', $entry);
    return $right;
}

# create_entry_attrs_form()
sub create_entry_attrs_form{
    my @edit_data = ();
    foreach my $attr (keys(%entry)){
	push(@edit_data, {entry_attr => $attr});
    }
    $tmpl->param(ATTR => \@edit_data);
}

# form to edit attrs
sub edit_entry_attrs_form{
    my $row = $_[0];
    my @edit_data = ();
    foreach my $attr (keys(%entry)){
	push(@edit_data, {entry_attr => $attr, entry_attr_value => $row->{$attr}});
    }
    $tmpl->param(ATTR => \@edit_data);
}

# retrive data
sub retrive_entry_id_data {
    my $dbh = $_[0];
    my $table = $db_entry_map{$current_entry};
    my $sth = $dbh->prepare("SELECT * FROM $table WHERE ID=$id");
    $sth->execute();
    my @attr_data = ();
    while (my $ref = $sth->fetchrow_hashref()) {
	#push(@attr_data, {entry_attr => 'ID', entry_attr_value => $id});
	foreach my $attr (keys (%entry)){
	    my %row_data;
	    $row_data{'entry_attr'} = $attr;
	    if ($ref->{$attr}){
		$row_data{'entry_attr_value'} = $ref->{$attr};
	    } else {
		$row_data{'entry_attr_value'} = ' ';
	    }
	    push(@attr_data, \%row_data);
	}

    }
    $sth->finish();
    $tmpl->param(ATTR => \@attr_data);
}

# form header
sub ProcessCMD{
    my @command;
    if ($CMD eq 'create'){
	push (@command, {CMD => 'insert'});
    } else {
	push(@command, {CMD => 'create'});
    }
    push(@command, {CMD => 'browse'});
    if ($CMD eq 'edit'){
	push(@command, {CMD => 'update'});
    } else {
	push(@command, {CMD => 'edit'});
    }
    push(@command, {CMD => 'delete'}, {CMD => 'search'});
    $tmpl->param(command => \@command);
}

# get table max id number
sub get_table_max_id {
    my $dbh = $_[0];
    my $table = $_[1];

    my $sth = $dbh->prepare("SELECT MAX(ID) FROM $table");
    $sth->execute();
    my @result = $sth->fetchrow_array();
    my $id = $result[0];

    return $id;
}

# change id
sub update_id {
    my $dbh = $_[0];
    my $new_id = $_[1];
    if ($new_id eq 'MAX'){
	my $table = $db_entry_map{$current_entry};
	my $maxid = get_table_max_id($dbh, $table);
	$tmpl->param(ID => $maxid);
	$id = $maxid;
    } else {
	$id = $new_id;
	$tmpl->param(ID => $new_id);
    }
}

sub update_entry {
    my $new_entry = $_[0];
    $current_entry = $new_entry;
    %entry = get_attrs($current_entry);
    $tmpl->param(ENTRY => $new_entry);
    $tmpl->param(Work => 1) if $current_entry eq 'work';
    $tmpl->param(Expression => 1) if $current_entry eq 'expression';
    $tmpl->param(Manifestation => 1) if $current_entry eq 'manifestation';
    $tmpl->param(Person => 1) if $current_entry eq 'person';
    $tmpl->param(Corporate_Body => 1) if $current_entry eq 'corporate_body';
    $tmpl->param(Event => 1) if $current_entry eq 'event';
    $tmpl->param(Place => 1) if $current_entry eq 'place';
    $tmpl->param(Concept => 1) if $current_entry eq 'concept';
    $tmpl->param(Object => 1) if $current_entry eq 'object';
}

# handle relation data

sub create_temp_entry {
    my $dbh = $_[0];
    my $temp_entry = $_[1];

    my $table = $db_entry_map{$temp_entry};
    my $sql_statement = "INSERT INTO $table (`ID`) VALUES ('0')";
    my $sth = $dbh->prepare($sql_statement);
    $sth->execute();
    $sth->finish();
    
    return get_table_max_id($dbh, $table);
}

sub add_relation_data {
    my ($dbh, $prev_entry ,$prev_id, $next_entry, $next_id, $relation_type) = @_;
    my $sql_statement = "INSERT INTO relation (`entry_left`,`entry_left_id`, `entry_right`, `entry_right_id`, `relation_type`) VALUES ('$prev_entry' ,'$prev_id', '$next_entry', '$next_id', '$relation_type')";
    my $sth = $dbh->prepare($sql_statement);
    $sth->execute();
    $sth->finish();
}

sub relation_admin {
    my $dbh = $_[0];
    if ($RT_CMD ne 'NONE'){
	my $prev_entry = param('P_ENTRY');
	my $prev_id = param('P_ID');
	if ($RT_CMD eq 'add'){
	    my ($relation_type, $next_entry )= split(':',param('selected_type'));
	    my $next_id = create_temp_entry($dbh, $next_entry);
	    add_relation_data($dbh, $prev_entry ,$prev_id, $next_entry, $next_id, $relation_type);
	    update_id($dbh, $next_id);
	    update_entry($next_entry);
	    $CMD='edit';
	} elsif ($RT_CMD eq 'delete'){
	    # delete_relation_data();
	}
    }
}

sub get_relation_db {
    my ($dbh, $entry, $id, $link) = @_;
    my @rt_data;
    my $sql_statement;

    if (($link eq 'right') || ($link eq 'down') || ($link eq 'up')){
	$sql_statement = "select `entry_right`, `entry_right_id`, `relation_type` from relation where `entry_left`='$entry' and `entry_left_id`=$id";
    } elsif ( $link eq 'left' ) {
	$sql_statement = "select `entry_left`, `entry_left_id`, `relation_type` from relation where `entry_right`='$entry' and `entry_right_id`=$id";
    }
    my $sth = $dbh->prepare($sql_statement);
    $sth->execute();
    while (my $ref = $sth->fetchrow_hashref()) {
	if (($link eq 'right') || ($link eq 'down') || ($link eq 'up')){
	    push (@rt_data, {entry => $ref->{entry_right}, id => $ref->{entry_right_id}, type => $ref->{relation_type}});
	} elsif ( $link eq 'left'){
	    push (@rt_data, {entry => $ref->{entry_left}, id => $ref->{entry_left_id}, type => $ref->{relation_type}});
	}
    }
    $sth->finish();
    return @rt_data;
}
sub filter_entry_relation {
    my ($ref_rt, $ref_ga, $ref_gb) = @_;
    my %entry_filtered;
    my @k = keys(%$ref_rt);

    foreach my $rt_key (keys(%$ref_rt)) {
        my $found_a = 0;
        my $found_b = 0;
        my($rta, $rtb) = split('-', $rt_key);
        foreach my $ga (@{$ref_ga}){
            if ($rta =~/$ga/){
                $found_a = 1;
                last;
            }
	}
        foreach my $gb (@{$ref_gb}){
            if ($rtb =~ /$gb/){
                $found_b = 1;
                last;
            }
	}
	if (($found_a == 1) && ($found_b == 1)){
	    @entry_filtered{$rt_key} = @$ref_rt{$rt_key};
	}
    }
    return %entry_filtered;

}
sub get_type_for_new_relation {
    my ($entry, $link) = @_;
    # set/get relation type
    my %rt = get_entry_relation_type($entry);
    my %frt;
    my @tmpl_data;
    if (($link eq 'left') || ($link eq 'right')){
	%frt = filter_entry_relation(\%rt, \@Entry_G1, \@Entry_G1);
    } elsif ($link eq 'down'){
	%frt = filter_entry_relation(\%rt, \@Entry_G2, \@Entry_G1);
    } elsif($link eq 'up'){
	%frt = filter_entry_relation(\%rt, \@Entry_G3, \@Entry_G1);
    }

    # get relation for new entry
    foreach my $rt_entry (keys(%frt)){
	
	#print "$link -> $rt_entry...\n";
	my $link_relation;
	if ($link eq "right") {
	    $link_relation = get_left_relation($rt_entry);
	} elsif ($link eq "left") {
	    $link_relation = get_right_relation($rt_entry);
	} elsif (($link eq "down") || ($link eq "up")) {
	    $link_relation = get_left_relation($rt_entry);
	}
	#print "$link --> $link_relation\n";

	if ($link_relation =~ /$entry/i) {
	    foreach my $type_of_entry (@{$frt{$rt_entry}}) {
		#print "$link ---> $type_of_entry\n";
		my %tmpl_desc;
		$tmpl_desc{'RT_TYPE'} = $type_of_entry;
		if ($link eq 'right'){
		    $tmpl_desc{'RT_NEXT'} = get_right_relation($rt_entry);
		    $tmpl_desc{'RT_DESC'} = get_left_relation_type_desc($type_of_entry);
		} elsif ($link eq 'left'){
		    $tmpl_desc{'RT_NEXT'} = get_left_relation($rt_entry);
		    $tmpl_desc{'RT_DESC'} = get_right_relation_type_desc($type_of_entry);
		}
		#print "$link ----> $tmpl_desc{'RT_NEXT'}\n";
		#print "$link ----> $tmpl_desc{'RT_DESC'}\n";
		push(@tmpl_data, \%tmpl_desc);
	   }
	}
	if (($link eq 'down') || ($link eq 'up')) {
	    foreach my $type_of_entry (@{$frt{$rt_entry}}) {
		my %tmpl_desc;
		$tmpl_desc{'RT_NEXT'} = get_left_relation($rt_entry);
		$tmpl_desc{'RT_DESC'} = get_right_relation_type_desc($type_of_entry);
		#print "$link ----> $tmpl_desc{'RT_NEXT'}\n";
		#print "$link ----> $tmpl_desc{'RT_DESC'}\n";
		push(@tmpl_data, \%tmpl_desc);
	    }
	}
    }
    return @tmpl_data;
}

sub get_entry_col {
    my ($dbh, $entry, $entry_id, $col) = @_;
    my $table = $db_entry_map{$entry};
    my $sql_statement = "select `$col` from $table where `ID`=$entry_id";
    my $sth = $dbh->prepare($sql_statement);
    $sth->execute();
    my @result = $sth->fetchrow_array();
    return $result[0];;
}

sub default_column {
    my $entry = $_[0];
    return "title_work" if $entry eq 'work';
    return "title_expression" if $entry eq 'expression';
    return "title_manifestation" if $entry eq 'manifestation';
    return "item_identifier" if $entry eq 'item';
    return "name" if $entry eq 'person';
    return "name" if $entry eq 'corporate_body';
    return "term" if $entry eq 'concept';
    return "term" if $entry eq 'object';
    return "term" if $entry eq 'event';
    return "term" if $entry eq 'place';
}

sub get_title_from_entry_id {
    my ($dbh, $entry, $id) = @_;

    return get_entry_col($dbh, $entry, $id, default_column($entry));
}

sub get_current_relation{
    my ($dbh, $current_entry, $id, $link) = @_;
    my @entry_link;
    my @exist_rt;

    @exist_rt = get_relation_db($dbh, $current_entry, $id, $link);
    foreach my $rt (@exist_rt){
	my @filter;
	my $found = 0;
	if ($link eq 'right') {
	    @filter = @Entry_G1;
	} elsif ($link eq 'up'){
	    @filter = @Entry_G3;
	} elsif ($link eq 'down'){
	    @filter = @Entry_G2;
	}
	foreach my $grt (@filter) {
	    if ($rt->{'entry'} =~ /$grt/){
		$found = 1;
		last;
	    }
	}
	if ($found == 1){
	    my %data;
	    $data{'entry'} = $rt->{'entry'};
	    $data{'id'} = $rt->{'id'};
	    #data{'type'} = $rt->{'type'};
	    $data{'desc'} = get_right_relation_type_desc($rt->{'type'});
	    $data{'title'} = get_title_from_entry_id($dbh, $rt->{'entry'}, $rt->{'id'});
	    push(@entry_link, \%data);
	}
    }
    return @entry_link;
}

# main
# FRBR Group
sub main {

    # Database Connect
    my ($host, $database, $user, $password) = ('localhost', 'frbr', 'root', 'okok7480');
    my $dbh = DBI->connect("DBI:mysql:database=$database;host=$host",$user,$password);

    update_entry($current_entry);
    relation_admin($dbh);
    # process your CMD
    ProcessCMD();

    my $table = $db_entry_map{$current_entry};
    if ($CMD eq 'create') {  # CMD for create entry #

	$tmpl->param(tmpl_create => 1);
	create_entry_attrs_form();

    } elsif ($CMD eq 'edit') {	# CMD for load form to edit entry attrs #

	$tmpl->param(tmpl_edit => 1);
	# retrive data from database
	my $sth = $dbh->prepare("SELECT * FROM $table where ID=$id");
	$sth->execute();
	while (my $ref = $sth->fetchrow_hashref()) {
	    edit_entry_attrs_form($ref);
	}
	$sth->finish();

    } elsif ($CMD eq 'update') { # CMD for update data to database #

	my %attrs;
	my @update_data;
	my $update_data;

	foreach my $attr (keys(%entry)){ 
	    $attrs{$attr} = "'".param($attr)."'" if (param($attr) ne "");
	}

	foreach my $attr_key ( keys ( %attrs ) ) {
	    push ( @update_data, "$attr_key=$attrs{$attr_key}" );
	}
	$update_data = join (',', @update_data);

	my $sql_statement = "UPDATE $table SET $update_data WHERE ID=$id";
	my $sth = $dbh->prepare($sql_statement);
	$sth->execute();
	$sth->finish();

	$tmpl->param(tmpl_browse => 1);
	# retrive data from database
	retrive_entry_id_data($dbh);

    } elsif ($CMD eq 'insert') {    # CMD for new data to database#

	#generate UUID
	#my $ug    = new Data::UUID;
	#my $uuid  = $ug->create();
	#my $uuid_str = $ug->to_string( $uuid );

	# progress for all param from web form
	my %attrs;
	foreach my $attr (keys(%entry)){ 
	    $attrs{$attr} = "'".param($attr)."'" if (param($attr) ne "");
	}

	my @idsql;
	while (my($k, $v) = each(%attrs)) {
	    my $sql = $k.'='.$v;
	    push(@idsql, $sql);
	}
	my $sql_statement2 = join(' and ', @idsql);

	my $sql_statement;
	# prepare column and values
	my $tbl_column = join(',', keys(%attrs));
	my $tbl_values = join(',', values(%attrs));
	$sql_statement = "INSERT INTO $table ($tbl_column) VALUES ($tbl_values)";

	# run sql statement
	my $sth = $dbh->prepare($sql_statement);
	$sth->execute();
	$sth->finish();

	# get new ID 
	# fix me in the future, using UUID
	$sql_statement = "select ID from  $table where $sql_statement2";
	$sth = $dbh->prepare($sql_statement);
	$sth->execute();
	my $result = $sth->fetchrow_hashref();
	update_id($dbh, $result->{ID});

	$tmpl->param(tmpl_browse => 1);
	# retrive data from database
	retrive_entry_id_data($dbh);

    } elsif ($CMD eq 'delete') { # CMD for browse all entry attrs #
	my $sth = $dbh->prepare("DELETE FROM $table WHERE ID=$id");
	$sth->execute();
	$sth->finish();

    } elsif ($CMD eq 'browse') { # CMD for browse all entry attrs #

	$tmpl->param(tmpl_browse => 1);
	# retrive data from database
	update_id($dbh, 'MAX') if ($id eq 'MAX');
	retrive_entry_id_data($dbh);

    }

    # relation for G1 (left and rigth)
    my @right_data = get_type_for_new_relation($current_entry, 'right');
    $tmpl->param(RIGHT_TYPE_DESC_LOOP => \@right_data);

    my @left_data = get_type_for_new_relation($current_entry, 'left');
    $tmpl->param(LEFT_TYPE_DESC_LOOP => \@left_data);

    # get exist relation type and entry
    my @left_entry_link = get_current_relation($dbh, $current_entry, $id, 'left');
    $tmpl->param(LEFT_ENTRY_LOOP => \@left_entry_link);

    my @right_entry_link = get_current_relation($dbh, $current_entry, $id, 'right');
    $tmpl->param(RIGHT_ENTRY_LOOP => \@right_entry_link);

    # relation for G2 (down)
    my @down_data = get_type_for_new_relation($current_entry, 'down');
    $tmpl->param(DOWN_TYPE_DESC_LOOP => \@down_data);

    my @down_entry_link = get_current_relation($dbh, $current_entry, $id, 'down');
    $tmpl->param(DOWN_ENTRY_LOOP => \@down_entry_link);

    # relation for G3 (up)
    my @up_data = get_type_for_new_relation($current_entry, 'up');
    $tmpl->param(UP_TYPE_DESC_LOOP => \@up_data);

    my @up_entry_link = get_current_relation($dbh, $current_entry, $id, 'up');
    $tmpl->param(UP_ENTRY_LOOP => \@up_entry_link);

    # Database disconnect
    $dbh->disconnect();

    # send the obligatory Content-Type and print the template output
    print "Content-Type: text/html\n\n", $tmpl->output;

    # end of main
}

main ();
