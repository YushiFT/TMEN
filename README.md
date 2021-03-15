<!---
This README uses Markdown syntax, though it is saved in .txt format.
To view the file with its intended text formatting, save a copy as a .md file.
Then you can open it with the browser or text viewer of your choice.
For details on Markdown syntax, see <https://daringfireball.net/projects/markdown/>.
--->

Reference Information
=====================

Provenance for this README
--------------------------

* File name: README_TMEN_Data.txt
* Author: Yushi Tang
* Other contributors: Donghui Wen
* Date created: 2021-03-01
* Date modified: 2021-03-15

Dataset Version and Release History
-----------------------------------

* Current Version:
  * Number: 1.0
  * Date: 2021-03-15
  * Persistent identifier: <https://doi:10.1007/s00248-019-01421-8>

Dataset Attribution and Usage
-----------------------------

* Dataset Title: TMEN Dataset

* Persistent Identifier: <https://doi:10.1007/s00248-019-01421-8>

* Dataset Contributors:

  * Creators: Yushi Tang and Donghui Wen

* Date of Issue: 2021-03-15

* Publisher: Peking University

* License:
  * Title: Creative Commons Attribution 4.0 International (CC BY 4.0)
  * Specification: <https://creativecommons.org/licenses/by/4.0/>

* Suggested Citations:

  * Dataset citation:
    > Tang, Y., Dai, T., Su, Z. et al. A Tripartite Microbial-Environment Network Indicates How Crucial Microbes Influence the Microbial Community Ecology. Microb Ecol (2019) <https://doi.org/10.1007/s00248-019-01421-8>.

Contact Information
-------------------

* Primary Contact:
  * Name: Yushi Tang
  * Affiliation: Princeton University
  * ORCID ID: 0000-0002-3809-2129
  * Email: yushi.tang@princeton.edu

* Alternative Contact:
  * Name: Donghui Wen
  * Affiliation: Peking University
  * ORCID ID: 0000-0002-1301-989X
  * Email: dhwen@pku.edu.cn

* Contributor ORCID IDs (see above)

- - -

Additional Dataset Metadata
===========================

Acknowledgements
----------------

* Funding source: General Project Nos. 51678003 and 51678334 of Natural Science Foundation

Relations to Other Datasets and/or Publications
-----------------------------------------------

* References for replication code for the dataset and related analyses:
  * Tang, Y., Dai, T., Su, Z. et al. A Tripartite Microbial-Environment Network Indicates How Crucial Microbes Influence the Microbial Community Ecology. Microb Ecol (2019) <https://doi.org/10.1007/s00248-019-01421-8>.

 
Dates and Locations
-------------------

* Dates of data collection: start=2015-04-01; end=2015-04-30

* Geographic locations of data collection: Hangzhou Bay, Zhejiang, PRC 

- - -

Methodological Information
==========================

* Methods of data collection: The data were collected following the procedures developed by Wen Lab at Peking University, as detailed in Dai, Tianjiao, et al. 2016 <https://doi.org/10.1093/femsec/fiw203>.

* Methods of data processing: Raw measurements were compiled into one CSV with minimal processing, as detailed in "TMEN_Codebook_2021-03-15.pdf".

* Software-specific information: The dataset and codebook do not require any specific software to read and reuse, but the data package follows the Frictionless Data framework, which has libraries for multiple languages: <https://frictionlessdata.io/tooling/libraries/#data-package>.

- - -

Data and File Overview
======================

Summary Metrics
---------------

* File count: 5
* Total file size: 4.8 MB
* Range of individual file sizes: 9 KB - 3.2 MB
* File formats: TXT, CSV, JSON, PDF

Naming Conventions
------------------

* File naming scheme: Each file name has three fields, delimimited by underscores (followed by the file extension):
    1. Project shorthand: "TMEN" in all cases
    2. Content type: "RawData"; "README"; "DataPackageDescriptor"; or "Codebook"
    3. Date of latest revision to the file by the creators

Table of Contents
-----------------

* TMEN_README_2021-03-15.txt, 9 KB
* TMEN_RawData_Bacteria_Species_2021-03-15.csv, 152 KB
* TMEN_RawData_Archaea_Species_2021-03-15.csv, 22 KB
* TMEN_DataPackageDescriptor_2021-03-15.json, 1.5 MB
* TMEN_Codebook_2021-03-15.pdf, 3.2 MB

- - -

File Details
============

Details for: README_2021-03-15.txt
----------------------------------------------

* Description: This is the README file you are reading right now--the introduction to the dataset and accompanying documentation files.

* Format:
  * Extension: .txt
  * Media type: text/plain
  * Encoding: UTF-8

* Size: 9 KB

Details for: TMEN_RawData_Bacteria_Species_2021-03-15.csv
-----------------------------------------------

* Description: This file represents the dataset itself; all other files are documentation for the dataset.

* Format:
  * Extension: .csv
  * Media type: text/csv
  * Encoding: UTF-8
  * Standard: RFC 4180 (<https://tools.ietf.org/html/rfc4180>)

* Size: 152 KB

* Dimensions: 1406 rows; 36 columns

* Variables:
  * The first line contains variable names as column headers.
  * The full details on all variables, including naming schemes, descriptions and value types, are contained in the data package and the codebook.

* Missing data codes: Missing values are left blank in all cases.

* Other encoding details:
  * A comma is used as the record separator and CRLF as the line break (per RFC 4180).
  * All string values are enclosed in double quotes (some contain punctuation, but none contain quotation marks)
  * Timestamps follow the ISO 8601 standard (<https://www.iso.org/standard/70907.html>; see also <https://en.wikipedia.org/wiki/ISO_8601>).

Details for: TMEN_RawData_Archaea_Species_2021-03-15.csv
-----------------------------------------------

* Description: This file represents the dataset itself; all other files are documentation for the dataset.

* Format:
  * Extension: .csv
  * Media type: text/csv
  * Encoding: UTF-8
  * Standard: RFC 4180 (<https://tools.ietf.org/html/rfc4180>)

* Size: 22 KB

* Dimensions: 168 rows; 36 columns

* Variables:
  * The first line contains variable names as column headers.
  * The full details on all variables, including naming schemes, descriptions and value types, are contained in the data package and the codebook.

* Missing data codes: Missing values are left blank in all cases.

* Other encoding details:
  * A comma is used as the record separator and CRLF as the line break (per RFC 4180).
  * All string values are enclosed in double quotes (some contain punctuation, but none contain quotation marks)
  * Timestamps follow the ISO 8601 standard (<https://www.iso.org/standard/70907.html>; see also <https://en.wikipedia.org/wiki/ISO_8601>).


Details for: TMEN_DataPackageDescriptor_2021-03-15.json
--------------------------------------------------------------

* Description: Following the Frictionless Data Specs (<https://frictionlessdata.io/specs/>), this JSON file serves as a "descriptor" to allow one to work with the dataset as a "data package" (<https://specs.frictionlessdata.io/data-package/>). It contains much the same information as in this README and the accompanying codebook--i.e., thorough metadata, variable details, and comprehensive information on value types--but in a machine-readable format.

* Format:
  * Extension: .json
  * Media type: application/json
  * Encoding: UTF-8
  * Standard: STD 90 (<https://tools.ietf.org/html/std90>)

* Size: 1.5 MB

* Other encoding details:
  * Generated using the Data Package Creator browser tool (<https://create.frictionlessdata.io/>), with "Profile" set to "Data Package."

Details for: TMEN_Codebook_2021-03-15.pdf
------------------------------------------------

* Description: This codebook provides comphrensive documentation for the all of the variables and values in the dataset in a human-readable form. This includes variable naming schemes, labels and descriptions for all variables (including some descriptive statistics), as well as details on all value types and units of measurement.

* Format(s):
  * Extension: .pdf
  * Media type: application/pdf
  * Standard: ISO 32000 (<https://www.iso.org/standard/51502.html>; see also <https://www.loc.gov/preservation/digital/formats/fdd/fdd000277.shtml>)

* Size: 3.2 MB

* Pages: 72

- - -
END OF README
