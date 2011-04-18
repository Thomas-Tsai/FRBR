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
my @Entry_G1 = qw(work expression manifestation item);
my @Entry_G2 = qw(person corporate_body);
my @Entry_G3 = qw(concept object event place);
my @Entry = [@Entry_G1, @Entry_G2, @Entry_G3];
my $current_entry = param('entry');
$current_entry = 'work' if (param('entry') eq '');


# CMD include 'create || insert || edit || delete ||browse(default)'
my $CMD = param('CMD');
$CMD = 'browse' if (param('CMD') eq '');

my %entry;
my $t = tie(%entry, 'Tie::IxHash');
%entry = get_attrs($current_entry);

my %db_entry_map = (
    'work'              => 'Work_Attrs',
    'expression'        => 'Expression_Attrs',
    'manifestation'     => 'Manifestation_Attrs',
    'item'              => 'Item_Attrs',
    'person'            => 'Person_Attrs',
    'corporate_body'    => 'Corporate_bod_Attrs',
    'concept'           => 'Concept_Attrs',
    'object'            => 'Object_Attrs',
    'event'             => 'Event_Attrs',
    'place'             => 'Place_Attrs'
);

my $table = $db_entry_map{$current_entry};
$tmpl->param(WORK => 1);

# Functions #

# get_table_relation_type
sub get_table_relation_type(){
    my %table_type;
    my %rt = get_relation_type();
    my $entry = $table;
    $entry =~ s/_Attrs//g;
    foreach my $type (keys(%rt)){
        if ($type =~ /$entry/i){
            $table_type{$type} = $rt{$type};
        }
    }
    return %table_type;
}

# create_entry_attrs_form()
sub create_entry_attrs_form{
    foreach my $attr (keys(%entry)){
        #print p($entry{$attr}, textfield($attr,''));
    }
    #print "Relation type:<br /\>\n";
    my %table_type = get_table_relation_type();
    foreach my $type (keys(%table_type)){
        #print p($type);
        #print scrolling_list($type, $table_type{$type});
    }

}

# form to edit attrs
sub edit_entry_attrs_form{
    my $row = $_[0];
    foreach my $attr (keys(%entry)){
        #print p($entry{$attr}, textfield($attr.'_'.$row->{'ID'}, $row->{$attr}));
    }
    #print "Relation type:<br /\>\n";
    my %table_type = get_table_relation_type();
    foreach my $type (keys(%table_type)){
        #print p($type);
        #print scrolling_list($type, $table_type{$type});
    }

    #print hidden('ID', $row->{'ID'});

}

# form header
sub base_form_header{
    #print start_form("post", "frbr.pl", "");
    #print popup_menu('entry', @Entry, $current_entry);
    if ($CMD eq 'create'){
        #print submit('CMD','insert');
    } else {
        #print submit("CMD", "create");
    }
    #print submit("CMD", "browse");
    if ($CMD eq 'edit'){
        #print submit('CMD','update');
    } else {
        #print submit("CMD", "edit");
    }
    #print submit("CMD", "delete");
    #print submit("CMD", "search");
}

# form footer
sub base_form_footer{
    #print end_form();
}


# main
# FRBR Group
sub main(){

# Database Connect
my ($host, $database, $user, $password) = ('localhost', 'frbr', 'root', 'okok7480');
my $dbh = DBI->connect("DBI:mysql:database=$database;host=$host",$user,$password);

# process your CMD

# print html and header
#print header(),start_html();
base_form_header();

# CMD for create entry
if ($CMD eq 'create'){
    create_entry_attrs_form();

# CMD for load form to edit entry attrs
} elsif ($CMD eq 'edit') {
    my @ID = param('ID');

    foreach my $ID (@ID){
        # retrive data from database
        my $sth = $dbh->prepare("SELECT * FROM $table where ID=$ID");
        $sth->execute();
        while (my $ref = $sth->fetchrow_hashref()) {
            edit_entry_attrs_form($ref);
        }
        $sth->finish();
    }

# CMD for update data to database
} elsif ($CMD eq 'update') {
    my @ID = param('ID');
    
    foreach my $ID (@ID){
        my %attrs;
        my @update_data;
        my $update_data;

        foreach my $attr (keys(%entry)){ 
            next if ($attr eq "CMD");
            my $value_id = $attr.'_'.$ID;
            $attrs{$attr} = "'".param($value_id)."'" if (param($value_id) ne "");
            #print ("$ID column $attr = ".param($value_id)."\n</br>");
        }
        
        foreach my $attr_key ( keys ( %attrs ) ) {
            push ( @update_data, "$attr_key=$attrs{$attr_key}" );
        }
        $update_data = join (',', @update_data);

        my $sql_statement = "UPDATE $table SET $update_data WHERE ID=$ID";
        my $sth = $dbh->prepare($sql_statement);
        $sth->execute();
        $sth->finish();
    }

# CMD for new data to database
} elsif ($CMD eq 'insert') {

    # progress for all param from web form
    my %attrs;
    foreach my $attr (keys(%entry)){ 
        next if ($attr eq "CMD");
        $attrs{$attr} = "'".param($attr)."'" if (param($attr) ne "");
        #print ("The column $attr = ".param($attr)."\n</br>");
    }

    foreach my $attr_key(keys(%attrs)){
        #print ("The column $attr_key = $attrs{$attr_key} will be insert/update\n</br>");
    }
    my $sql_statement;
    # prepare column and values
    my $tbl_column = join(',', keys(%attrs));
    my $tbl_values = join(',', values(%attrs));
    $sql_statement = "INSERT INTO $table ($tbl_column) VALUES ($tbl_values)";

    # run sql statement
    my $sth = $dbh->prepare($sql_statement);
    $sth->execute();
    $sth->finish();

# CMD for browse all entry attrs
} elsif ($CMD eq 'delete') {
    my @ID = param('ID');
    foreach my $id (@ID){
        my $sth = $dbh->prepare("DELETE FROM $table WHERE ID=$id");
        $sth->execute();
        $sth->finish();
    }
# CMD for browse all entry attrs
} elsif ($CMD eq 'browse') {

    my $id = param('ID');
    # retrive all data from database
    my $sth = $dbh->prepare("SELECT * FROM $table WHERE ID=$id");
    $sth->execute();
    #my @td_data = ();
    my @attr_data = ();
    while (my $ref = $sth->fetchrow_hashref()) {
     #   my @attr_values = ();
        foreach my $attr (keys (%entry)){
            my %row_data;
            $row_data{'entry_attr'} = $attr;
            if ($ref->{$attr}){
     #           push (@attr_values, $ref->{$attr});
                $row_data{'entry_attr_value'} = $ref->{$attr};
            } else {
     #           push (@attr_values, ' ');    
                $row_data{'entry_attr_value'} = ' ';
            }
            push(@attr_data, \%row_data);
        }
        #unshift (@attr_values, $ref->{'ID'});
        #push (@td_data, Tr(td([checkbox('ID', 0, $ref->{'ID'}, ''), @attr_values])));

    }
    $sth->finish();
    #print table( {-border=>"1"},
          #Tr(td(['', 'ID', values %entry])),
          #@td_data,
          #);
    $tmpl->param(ATTR => \@attr_data);
}

base_form_footer();

# send the obligatory Content-Type and print the template output
print "Content-Type: text/html\n\n", $tmpl->output;
#print end_html();
# Database disconnect
$dbh->disconnect();

# end of main
}


main ();
