<!DOCTYPE html>
<html>
	<?php
	require('include/functions.php');
	$title = 'Work Contents!';
	$work = '';

	if($_GET["work"]) {
		$work = $_GET["work"];
	}

	$pt = array($title);
	$pt_post = '';

	require('include/head.php');
	?>
	<body>
        <div id="outer">
			<?php
			require('include/header.php');
			?>
				
			<div id="content">
				<div id="content-inner">
					<div id="issue-heading">
						<div class="issue-heading-inner">
							<h1><?php echo $title; ?></h1>
						</div>
					</div>
					<div id="main">
						<div id="articles-reviews-index">
			<?php
				
			$docsXml = array();

			foreach (new DirectoryIterator("./xml/") as $fn) {
				if (preg_match('/'.$work.'.[.a-zA-Z0-9]{1,}.xml/', $fn->getFilename())) {
					$fn_t = array();
					$fn_t['fn'] = $fn->getFilename();
					$fn_t['file'] = str_replace('.xml', '', $fn_t['fn']);
					
					$FullXML = simplexml_load_file('xml/'.$fn_t['fn']); 
					$XMLdate = $FullXML->xpath('/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/date/@when');
					$fn_t['date'] = $XMLdate[0];
					$XMLnum = $FullXML->xpath('/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/@xml:id');
					$fn_t['num'] = str_replace('installment', 'Installment ', $XMLnum[0]);
					$XMLchapTitles = $FullXML->xpath('/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/title[@level="a"]');
					$fn_t['chapTitles'] = $XMLchapTitles; // array
					$XMLchapIDs = $FullXML->xpath('/TEI/text/body/div[@type="installment"]/div[@type="chapter"]/head/@xml:id');
					$fn_t['chapIDs'] = $XMLchapIDs; // array
					
					$docsXml[] = $fn_t;
				}
			}
			

			foreach ($docsXml as $file) {
				//usort($file, 'cmpArticle');
				print '<p><a class="issue-link" href="installment.php?file='.$file['file'].'">'.$file['num'].' ('.date('D, d M Y', strtotime($file['date'])).')</a></p>';
				if(count($file['chapTitles']) > 0) {
					print '<ul class="chapter-links">';
					for($i=0; $i<count($file['chapTitles']); $i++) {
						print '<li><a href="installment.php?file='.$file['file'].'#'.$file['chapIDs'][$i].'">'.$file['chapTitles'][$i].'</a></li>';
					}
					print '</ul>';
				}
			
			}
			
			?>
						</div> <!-- #articles-reviews-index -->
					</div> <!-- #main -->
					<?php
					include('include/footer.php');
					?>
				</div> <!-- #content-inner -->
			</div> <!-- #content -->
		</div> <!-- #outer -->
	</body>
</html>
