%let pgm=utl-linking-connected-nodes-in-a-network-graph-r-igraph;

Linking connected nodes in a network graph r igraph

github
https://tinyurl.com/572sdzez
https://github.com/rogerjdeangelis/utl-linking-connected-nodes-in-a-network-graph-r-igraph

Related Repos

https://github.com/rogerjdeangelis/utl-identify-linked-and-unliked-paths-r-igraph
https://github.com/rogerjdeangelis/utl_remove_isolated_nodes_from_an_network_r_igraph

https://github.com/rogerjdeangelis/utl-R-AI-igraph-list-connections-in-a-non-directed-graph-for-a-subset-of-vertices
https://github.com/rogerjdeangelis/utl-how-many-triangles-in-the-polygon-r-igraph-AI
https://github.com/rogerjdeangelis/utl-igraph-find-largest-group-of-unrelated-individuals-in-your-family-reunion
https://github.com/rogerjdeangelis/utl-shortest-and-longest-travel-time-from-home-to-work-igraph-AI

/*               _     _
 _ __  _ __ ___ | |__ | | ___ _ __ ___
| `_ \| `__/ _ \| `_ \| |/ _ \ `_ ` _ \
| |_) | | | (_) | |_) | |  __/ | | | | |
| .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
|_|
*/

/***************************************************************************************************************************/
/*                                                                                                                         */
/* INPUT                                                                                                                   */
/* =====                                                                                                                   */
/*                                                                                                                         */
/* za11>email21>ip21>address21>phone21                                                                                     */
/* za12>email22>ip21>address22>phone22                                                                                     */
/* za13>email22>ip22>address23>phone23                                                                                     */
/*                                                                                                                         */
/* RULES                                                                                                                   */
/* =====                                                                                                                   */
/*                                                                                                                         */
/* za11>email21>ip21>address21>phone21>                                                                                    */
/*              ====                                                                                                       */
/* za12>email22>ip21>address22>phone22> LINKED IP21                                                                        */
/*      ....... ====                                                                                                       */
/* za13>email22>ip22>address23>phone23  LINKED EMAIL122                                                                    */
/*      .......                                                                                                            */
/*                                                                                                                         */
/* OUTPUT (same as rules without duplicating the links node)                                                               */
/* =========================================================                                                               */
/*                                                                                                                         */
/* Note igraph simplifies the result because ip21 and email122                                                             */
/* are only needed once. No need to return to the node multiple times                                                      */
/*                                                                                                                         */
/* CONNECTIONS FROM ZA11 TO ZA13                                                                                           */
/*                                                                                                                         */
/* za11>email21>ip21>address21>phone21>za12>email22>address22>phone22>za13>ip22>address23>phone23                          */
/*                                                                                                                         */
/***************************************************************************************************************************/

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

options validvarname=upcase;
libname sd1 "d:/sd1";
data sd1.have(keep=str);
input (Application_ID Email_ID IP_ID Address_ID phone_ID) ( :$20.);
array chr _character_;
str=catx('>',of _character_);
cards4;
za11 email21 ip21 address21 phone21
za12 email22 ip21 address22 phone22
za13 email22 ip22 address23 phone23
;;;;
run;quit;


/**************************************************************************************************************************/
/*                                                                                                                        */
/*                   STR                                                                                                  */
/*                                                                                                                        */
/*   za11>email21>ip21>address21>phone21                                                                                  */
/*   za12>email22>ip21>address22>phone22                                                                                  */
/*   za13>email22>ip22>address23>phone23                                                                                  */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*
 _ __  _ __ ___   ___ ___  ___ ___
| `_ \| `__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
*/

%utl_submit_r64x('
library(igraph);
library(haven);
source("c:/temp/fn_tosas9.R");
data <-read_sas("d:/sd1/have.sas7bdat");
data<-as.character(data$STR);
spl <- strsplit(data,">");
combspl <- data.frame(
  grp = rep(seq_along(spl),lengths(spl)),
  val = unlist(spl));
cl <- clusters(graph.data.frame(combspl))$membership[-(1:length(spl))];
dat <- data.frame(cl);
dat[,2] <- row.names(dat);
want <- character(0);
for (i in 1:max(cl)) {
  want[i] <- paste(paste0(dat[(dat[,1] == i),][,2]), collapse=">");
};
fn_tosas9(dataf=want);
');

libname tmp "c:/temp";
proc print data=tmp.want width=min;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*                                             COL_0                                                                      */
/*                                                                                                                        */
/* za11>email21>ip21>address21>phone21>za12>email22>address22>phone22>za13>ip22>address23>phone23                         */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
