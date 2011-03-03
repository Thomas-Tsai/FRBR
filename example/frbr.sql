CREATE TABLE Work_Attrs 
(
   `ID` int(11) not null auto_increment,
   `title_work` text null,
   `form_work` text null,
   `date_work` text null,
   `other_distinguishing_characteristic` text null,
   `intended_termination` text null,
   `intended_audience` text null,
   `context_work` text null,
   `medium_performance_musical_work` text null,
   `numeric_designation_musical_work` text null,
   `key_musical_work` text null,
   `coordinates_cartographic_work` text null,
   `equinox_cartographic_work` text null,
   primary key(ID)
);
CREATE TABLE `Expression_Attrs` (
   `ID` int(11) NOT NULL auto_increment,
   `title_expression` text,
   `form_expression` text,
   `date_expression` text,
   `language_expression` text,
   `other_distinguishing_characteristic` text,
   `extensibility_expression` text,
   `revisability_expression` text,
   `extent_expression` text,
   `summarization_content` text,
   `context_expression` text,
   `critical_response_to_expression` text,
   `use_restrictions_expression` text,
   `sequencing_pattern` text,
   `expected_regularity_issue` text,
   `expected_frequency_issue` text,
   `type_score` text,
   `medium_performance` text,
   `scale` text,
   `projection` text,
   `presentation_technique` text,
   `representation_relief` text,
   `geodetic_grid_vertical_measurement` text,
   `recording_technique` text,
   `special_characteristic` text,
   `technique` text,
   primary key(ID)
  );
CREATE TABLE `Manifestation_Attrs` (
   `ID` int(11) NOT NULL auto_increment,
   `title_manifestation` text,
   `statement_responsibility` text,
   `edition_issue_designation` text,
   `place_publication_distribution` text,
   `publisher_distributor` text,
   `date_publication_distribution` text,
   `fabricator_manufacturer` text,
   `series_statement` text,
   `form_carrier` text,
   `extent_carrier` text,
   `physical_medium` text,
   `capture_mode` text,
   `dimensions_carrier` text,
   `manifestation_identifier` text,
   `source_acquisition_access_authorization` text,
   `terms_availability` text,
   `access_restrictions_manifestation` text,
   `typeface` text,
   `type_size` text,
   `foliation` text,
   `collation` text,
   `publication_status` text,
   `numbering` text,
   `playing_speed` text,
   `groove_width` text,
   `kind_cutting` text,
   `tape_configuration` text,
   `kind_sound` text,
   `special_reproduction_characteristic` text,
   `colour` text,
   `reduction_ratio` text,
   `polarity` text,
   `generation` text,
   `presentation_format` text,
   `system_requirements` text,
   `file_characteristics` text,
   `mode_access` text,
   `access_address` text,
   primary key(ID)
  );
CREATE TABLE `Item_Attrs` (
   `ID` int(11) NOT NULL auto_increment,
   `item_identifier` text,
   `fingerprint` text,
   `provenance_item` text,
   `marks_inscription` text,
   `exhibition_history` text,
   `condition_item` text,
   `treatment_history` text,
   `scheduled_treatment` text,
   `access_restrictions_item` text,
   primary key(ID)
  );


CREATE TABLE `Person_Attrs` (
   `ID` int(11) NOT NULL auto_increment,
   `name` text,
   `dates` text,
   `title` text,
   `other designation` text,
    primary key(ID)
);

CREATE TABLE `Corporate_body_Attrs` (
   `ID` int(11) NOT NULL auto_increment,
   `name` text,
   `number` text,
   `place` text,
   `date` text,
   `other designation` text,
    primary key(ID)
);

CREATE TABLE `Concept_Attrs` (
   `ID` int(11) NOT NULL auto_increment,
   `term` text,
    primary key(ID)
);

CREATE TABLE `Object_Attrs` (
   `ID` int(11) NOT NULL auto_increment,
   `term` text,
    primary key(ID)
);

CREATE TABLE `Event_Attrs` (
   `ID` int(11) NOT NULL auto_increment,
   `term` text,
    primary key(ID)
);

CREATE TABLE `Place_Attrs` (
   `ID` int(11) NOT NULL auto_increment,
   `term` text,
    primary key(ID)
);
