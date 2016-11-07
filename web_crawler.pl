#!/usr/bin/perl  
use LWP::Simple;

#L5-L23 (TAKING THE KEYWORD FROM USER AND VERIFICATION OF INPUT) 
while()
{
	print "ENTER THE PERSONALITY NAME YOU WANT TO LOOK FOR :- ";
	chomp($keyword = <STDIN>);
	print "$keyword";
	$keyword = lc $keyword;
	$keyword = ucfirst $keyword;	
	if($keyword eq '')
	{
		print "\nEMPTY STRING\n";
		redo ;
	}
	else
	{
		last;	
 
	}	
}
system(clear);


#L27-L34(CONVERSION OF INPUT INTO PROPER FORMAT TO EMBED FOR THE WIKIPEDIA) 
@UPkeyword =(split / / ,$keyword);
foreach $key (@UPkeyword)
{
	$key= ucfirst $key;
	push(@keywordUP,$key);
}
$keyword= join( '_' , @keywordUP);	
system(clear);

#L37-L48(TO CHECK INTERNET CONNECTION)
print " CHECKING CONNECTION \n\n\n\n ";
if(not system(" wget --spider http://www.google.com "))
{
	system(clear);
	print "Internet is connected\n";
}
else
{
	system(clear);
	print "UNABLE TO ACCESS INTERNET, PLZ CHECK YOUR INTERNET";
	exit;
}


#L52-L60(EXTRACTING WEB PAGE DATA )
my $URL ="https://en.wikipedia.org/wiki/";
$URL = $URL . $keyword;
print " $URL ";
my $content = get $URL;
if(not defined $content)
{
	die "Couldn't get $URL" ;
	exit;
}

#L63-L77 (CHECKING THE EXISTANCE AND PERMISSION OF FILE "temp1_web_crawler(THE FILE Will CONTAIN THE DATA OF PAGE SOURCE")
if(-e './temp1_web_crawler.txt')
{
	if(-w './temp1_web_crawler.txt')
	{
	}
	else
	{
		system("'chmod' '777' 'temp1_web_crawler.txt'");
	}
}
else
{
	system("'touch' 'temp1_web_crawler.txt'");
	system("'chmod' '777' 'temp1_web_crawler.txt'");
}


#L82-L84 (SAVED THE EXTRACTED DATA FROM THE URL INTO A FILE "temp1_web_crawler.txt")
open(my $MYE,"> temp1_web_crawler.txt");
print  $MYE $content;
close $MYE;


#L88-L103 (CHECKING THE EXISTANCE AND PERMISSION OF FILE "temp2_web_crawler(THE FILE Will CONTAIN THE DATA OF PAGE SOURCE")
if(-e './temp2_web_crawler.txt')
{
	if(-w './temp2_web_crawler.txt')
	{
	}
	else
	{
		system("'chmod' '777' 'temp2_web_crawler.txt'");
	}
}
else
{
	system("'touch' 'temp2_web_crawler.txt'");
	system("'chmod' '777' 'temp2_web_crawler.txt'");
}


#L105-L119 (CHECKING THE EXISTANCE AND PERMISSION OF FILE "temp3_web_crawler(THE FILE Will CONTAIN THE DATA OF PAGE SOURCE")
if(-e './temp3_web_crawler.txt')
{
	if(-w './temp3_web_crawler.txt')
	{
	}
	else
	{
		system("'chmod' '777' 'temp3_web_crawler.txt'");
	}
}
else
{
	system("'touch' 'temp3_web_crawler.txt'");
	system("'chmod' '777' 'temp3_web_crawler.txt'");
}

#L?????(OPENING THE FILE WHICH CONTANS THE SOUCE PAGE OF URL i.e temp1_web_crawler AND SAVING THE CLEANED CONTENT INTO temp2_web_crawler) 
open(MYINPUTFILE ,"< temp1_web_crawler.txt")||die "not able" ;
open(my $MYOUTPUTFILE ,">temp2_web_crawler.txt")|| die " NOT ABLE ";

while(<MYINPUTFILE>)
{
		if ($_ =~ m/>Contents</)
		{
			next;
		
		}
	if($_ =~ m/<h2>(.+)>See also<\/span>(.+)<\/h2>/)
		{
			last;
		}
	if($_ =~ m/<title>.*<\/title>/ || m/<h.*<\/h.*>/ || m/<p>.*<\/p>/ || m/<li>.*<\/li>/)
	{
	#	while($_ =~ m/<a href.*>/ || $_ =~ m/<\/a>/ || $_ =~ m/<span[^>]*>/ || m/<\/span>/ || m/<sup>.*<\/sup>/ || m/<sup[^w]*>/ || m/<\/sup>/ ) 
		{
			$_ =~ s/<a href[^>]*">//g;
			$_ =~ s/<\/a>//g;
			$_ =~ s/<span[^>]*>//g;
			$_ =~ s/<\/span>//g;
			$_ =~ s/<sup.*?<\/sup>//g;
			$_ =~ s/<sup[^w]*>//g;
			$_ =~ s/<\/sup>//g;
			$_ =~ s/<a rel[^>]*>//g;
			$_ =~ s/<img[^>]*>//g;
			$_ =~ s/\[.*\]//g;
			$_ =~ s/<p>//g;
			$_ =~ s/<i>//g;
			$_ =~ s/<\/i>//g;
			$_ =~ s/<b>//g;
			$_ =~ s/<\/b>//g;
			$_ =~ s/<p>//g;
			$_ =~  s/<tt>//g;
			$_ =~  s/<\/tt>//g;
			$_ =~ s/<div[^>]*>//g;
			$_ =~ s/<code>.*?<\/code>//g;
		}
		print $MYOUTPUTFILE  "\n$_\n";
	}
}
close MYINPUTFILE;
close $MYOUTPUTFILE;





open(myinputfile,"<temp2_web_crawler.txt");
open(myoutputfile,">temp3_web_crawler.txt");
while(<myinputfile>)
{
	if($_ =~ m/<title>/)
	{
		if($' =~ m/<\/title>/)
		{
			print myoutputfile "$`";
			print myoutputfile "$`";
		}
		print myoutputfile "\n===========================================================================================\n";
	}
	if($_ =~ m/<h[^>]*>/)
	{
		print myoutputfile "\n___________________________________________________________________________________________\n";
		if($' =~ m/<\/h.*>/)
		{
			if($` =~ m/External links/i)
			{
				last;
			}
				print myoutputfile "\n$`";
			print myoutputfile ":-\n";
		}
	}	
	if($_ =~ m/<\/p>/)
	{
		print myoutputfile "\n\t";
		print myoutputfile "$`\n";
	}
	if($_ =~ m/<li>/)
	{
		if($' =~ m/<\/li>/)
		{
			print myoutputfile "\to $` \n";
		}
	}
}
system("clear");
system("less temp3_web_crawler.txt");
