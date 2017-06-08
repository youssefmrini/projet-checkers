import java.util.Hashtable;
import javax.swing.JOptionPane;
import jpl.Atom;
import jpl.Query;
import jpl.Term;
public class Game implements Runnable {


    private String query1, query2;
    private static final int N = 8;
    private String[][] pieces = new String[N][N];
    private String[][] table = new String[N][N];
    private int[][] succ = new int[N][N];
    private String player1;
    private String player2,testeat;
    private boolean turn;
    public Thread m;
    private boolean movedone = false;
    private Board board;
    private static int sx = 100,sy = 100,ex = 100,ey = 100;
	private static int wichturn,win=0; // 1 pour player 1 2 pour player 2
	static int d  = Menu.d;
    private static int depth=d;
 
    

    public Game(String player1, String player2) {
    	
        this.player1 = player1;
        this.player2 = player2;
        init();
        start();
    }


    private void init() {

        if (player1.equals("User")){
        	
        	wichturn = 1;
        	
            query1 = "doeatw";}
        else if (player1.equals("IA AlphaBeta")){
        	
        	wichturn = 2;
            query1 = "callalphabetaw";}
       
        if (player2.equals("User")){
        	
        	wichturn = 2;
            query2 = "doeatb";}
        else if (player2.equals("IA AlphaBeta")){
        	
        	wichturn = 1;
            query2 = "callalphabetab";}

    }
    
    
	private void start() { 

    	Query q1 = new Query("consult", new Term[] {
                new Atom("IA/playch.pl") });
		System.out.println((q1.hasSolution() ? "succeeded" : "failed"));
		Query q2 = new Query("consult", new Term[] {
                new Atom("IA/checkers.pl") });
		System.out.println((q2.hasSolution() ? "succeeded" : "failed"));
		Query q3 = new Query("consult", new Term[] {
                new Atom("IA/mmn17alphabeta.pl") });
		System.out.println((q3.hasSolution() ? "succeeded" : "failed"));
        initTable();
        initPieces();
        initsucc();
        board = new Board(table, pieces,succ, this);
    }
	
	 public void set_mother(Thread m) {
	        this.m = m;
	    }

	private void initTable() {
	        for (int i = 0; i < N; ++i){
	            for (int j = 0; j < N; ++j){
	                if (i < 3 && (i + j) % 2 == 0 )
	            		table[i][j]= "wp";
	            	else if  (i > 4  && (i + j) % 2 == 0 )
	                	table[i][j]= "bp";
	                else if( i <= 4 && i >= 3 && (i + j) % 2 == 0)
	                	table[i][j]= "em";
	                else 
	                	table[i][j]= "+";
	             }
	         }
	    }
	private void initsucc() {
        for (int i = 0; i < N; ++i){
            for (int j = 0; j < N; ++j){
            	succ[i][j] = 0;
            }
        }
	}
	private void initPieces() {

	        for (int i = 0; i < N; ++i){
	            for (int j = 0; j < N; ++j){
	                if (i < 3 && (i + j) % 2 == 0 )
	                	pieces[i][j]= "wp";
	            	else if  (i > 4  && (i + j) % 2 == 0 )
	            		pieces[i][j]= "bp";
	                else if( i <= 4 && i >= 3 && (i + j) % 2 == 0)
	                	pieces[i][j]= "em";
	                else 
	                	pieces[i][j]= "+";
	             }
	         }
	    }
	
	private boolean checkWin(String  List) {


	        Query q2 = new Query("terminal(state(white,"+List+"), _)");
	        Query q1 = new Query("terminal(state(black,"+List+"), _)");
	        //q1.query();
	        System.out.println( "consult " + (!q2.query() ? "failed" : "succeeded"));
	        System.out.println( "consult " + (!q1.query() ? "failed" : "succeeded"));

	        q2.query(); q1.query();
	        
	        Hashtable solution1 = new Hashtable();
	        solution1 = q1.oneSolution();
	        //System.out.println(solution1);
	        
	        Hashtable solution2 = new Hashtable();
	        solution2 = q2.oneSolution();
	        //System.out.println(solution2);
	        
	        if (q1.hasSolution()) {
	            System.out.println("Player black won");  
	         JOptionPane.showMessageDialog(null, "Le joueur noir a gagné", "Message" , JOptionPane.INFORMATION_MESSAGE);
	         System.exit(0);
	            win = 1;
	            return true;
	        }
	        if (q2.hasSolution()) {
		         JOptionPane.showMessageDialog(null, "Le joueur blanc a gagné", "Message  " , JOptionPane.INFORMATION_MESSAGE);
		         System.exit(0);
	            win = 1;
	            return true;
	        }
	        return false;
	    }	   

	private String make_move(String List ) {
		System.out.println("**** make move ****");

		while(movedone != true){
        	wait(3000);}
			String str ="";	
			System.out.println(sx+"/"+sy+" to "+ex+"/"+ey);
				
				if ( query1 == "doeatw"){ 
					String str1 = "doeatagain(" + List + "," +sx+"/"+ sy + "," + ex + "/" + ey + ",NList,X)";
					Query q1 = new Query(str1); // from 3/4 too 6/2
			    	Hashtable solution= new Hashtable();
			    	solution = q1.oneSolution();
			    	 try {
						str = solution.get("NList").toString();
						testeat = solution.get("X").toString();
					} catch (Exception e1) {
						// TODO Auto-generated catch block
						//System.out.println(" eroor " +sx+"/"+ sy + "," + ex + "/" + ey);
						System.out.println(" illegal move  try again");
						movedone = false;
						run();
					}
			    	 if (testeat.equals("1")){
			    		 System.out.println(" You Need to eat again");
					    	movedone = false;
					    	sx = 100;sy = 100;ex = 100;ey = 100;
					    	char e="'".charAt(0);
					    	char k="(".charAt(0);
					    	char f=")".charAt(0);
				
					    	char v=",".charAt(0);
					    	char h="[".charAt(0);
					    	char l="]".charAt(0);
				
					    	StringBuffer stbuf = new StringBuffer();
				
				
					    	for(int i=0;i<str.length();i++)
					     	{	
					    	if(str.charAt(i)==k || str.charAt(i)==f || str.charAt(i)==v||str.charAt(i)==h||str.charAt(i)==l)
					    	{} 
				
					    	else{
					    	stbuf.append(str.charAt(i));
					    	 if(str.charAt(i)=='p' ||str.charAt(i)=='k'||str.charAt(i)=='m'||str.charAt(i)=='+')
					    	 {stbuf.append(',');}
					    	}
					    	}
				
								    	String res=stbuf.toString();
							
								    	String [] you = res.split("'.'");
								    	StringBuffer stbuff = new StringBuffer();
								    	for(int i=0;i<you.length;i++)
								    	stbuff.append(you[i]);
								    	StringBuffer st1 = new StringBuffer();
								    	String resultat=stbuff.toString();
								    	resultat=resultat.replaceAll("\\s+","");
								    	String[] resu = resultat.split(",");
								    	st1.append("[[");
					    	    
					    	for (int i = 0; i < resu.length; i++) {
					    		
					    		if(i%8==0  && i!=0){st1.append("]");st1.append(",");st1.append("[");}
					    		else{
					    			if(i%8==0){}
					    		else{st1.append(",");}
					    		    }
					    		st1.append(resu[i]);
					    		
					    	}
					    	st1.append("]]");
					    	updateTablePieces(st1.toString());
		        			for(int i = 0; i<8;i++)
		        				for(int j = 0 ; j<8;j++)
		        					succ[i][j] = 0;
		        			
		        			board.update(pieces, table, succ);
					    	//make_move(st1.toString());
					    	run();
	
			    	 }
		    	 }
		    	else{ 
		    		String str1 = "doeatb(" + List + "," +sx+"/"+ sy + "," + ex + "/" + ey + ",NList)";
			    	Query q1 = new Query(str1); // from 3/4 too 6/2
			    	Hashtable solution= new Hashtable();
			    	solution = q1.oneSolution();
			    	str=solution.get("NList").toString();
		    	 }
		    	
		    	if (str != null){
		    	//System.out.println("sent");
	      
	            }

		    	char e="'".charAt(0);
		    	char k="(".charAt(0);
		    	char f=")".charAt(0);
	
		    	char v=",".charAt(0);
		    	char h="[".charAt(0);
		    	char l="]".charAt(0);
	
		    	StringBuffer stbuf = new StringBuffer();
	
	
		    	for(int i=0;i<str.length();i++)
		     	{	
		    	if(str.charAt(i)==k || str.charAt(i)==f || str.charAt(i)==v||str.charAt(i)==h||str.charAt(i)==l)
		    	{} 
	
		    	else{
		    	stbuf.append(str.charAt(i));
		    	 if(str.charAt(i)=='p' ||str.charAt(i)=='k'||str.charAt(i)=='m'||str.charAt(i)=='+')
		    	 {stbuf.append(',');}
		    	}
		    	}
	
					    	String res=stbuf.toString();
				
					    	String [] you = res.split("'.'");
					    	StringBuffer stbuff = new StringBuffer();
					    	for(int i=0;i<you.length;i++)
					    	stbuff.append(you[i]);
					    	StringBuffer st = new StringBuffer();
					    	String resultat=stbuff.toString();
					    	resultat=resultat.replaceAll("\\s+","");
					    	String[] resu = resultat.split(",");
					    	st.append("[[");
		    	    
		    	for (int i = 0; i < resu.length; i++) {
		    		
		    		if(i%8==0  && i!=0){st.append("]");st.append(",");st.append("[");}
		    		else{
		    			if(i%8==0){}
		    		else{st.append(",");}
		    		    }
		    		st.append(resu[i]);
		    		
		    	}
		    	st.append("]]");
		    	movedone = false;
		    		return st.toString();
				
	   // }wait(3000);
	    //return null;
        }

	private String Callaphabeta(String List ,int Depth ) {
		System.out.println("**** alpha beta ****");
		String str = null ;
		if(query1 == "Callalphabetaw"){
	    	 String str7 = "alphabeta(state(white,"+List+ "),-1000, 1000, state(black,Nlist), Val," +  Depth + ")";
	    	Query q1 = new Query(str7); // List doit etre comme ca  L String ==>"doeatw("+L+",Nlist)"
	    	Hashtable solution1= new Hashtable();
	    	solution1 = q1.oneSolution();
	    	
	    	str=solution1.get("Nlist").toString();}
		else{

			String str7; 
			str7 = "alphabeta(state(black,"+List+ "),-1000, 1000, state(white,Nlist), Val," +  Depth + ")";
	    	Query q1 = new Query(str7); // List doit etre comme ca  L String ==>"doeatw("+L+",Nlist)"
	    	Hashtable solution1= new Hashtable();
	    	System.out.println("***"+List);
	    	
	    	/*while (q1.hasMoreSolutions()){
	    		 solution1 = q1.nextSolution();
			}*/
	    	try {
				solution1 = q1.oneSolution();
				str=solution1.get("Nlist").toString();
			} catch (Exception e) {
				try {
					Depth --;
					System.out.println(" becareful2! ");
					/*wichturn = 1;
					run();*/
					str7 = "alphabeta(state(black,"+List+ "),-1000, 1000, state(white,Nlist), Val," +  Depth + ")";
					 q1 = new Query(str7); // List doit etre comme ca  L String ==>"doeatw("+L+",Nlist)"
					 solution1 = q1.oneSolution();
					 str=solution1.get("Nlist").toString();
				} catch (Exception e1) {
					Depth --;
					System.out.println(" becareful2! ");
					/*wichturn = 1;
					run();*/
					str7 = "alphabeta(state(black,"+List+ "),-1000, 1000, state(white,Nlist), Val," +  Depth + ")";
					 q1 = new Query(str7); // List doit etre comme ca  L String ==>"doeatw("+L+",Nlist)"
					 solution1 = q1.oneSolution();
				}
			}
			
		}
	    	if (str != null){
	    	
	    	char e="'".charAt(0);
	    	char k="(".charAt(0);
	    	char f=")".charAt(0);

	    	char v=",".charAt(0);
	    	char h="[".charAt(0);
	    	char l="]".charAt(0);

	    	StringBuffer stbuf = new StringBuffer();


	    	for(int i=0;i<str.length();i++)
	     	{	
	    	if(str.charAt(i)==k || str.charAt(i)==f || str.charAt(i)==v||str.charAt(i)==h||str.charAt(i)==l)
	    	{} 

	    	else{
	    	stbuf.append(str.charAt(i));
	    	 if(str.charAt(i)=='p' ||str.charAt(i)=='k'||str.charAt(i)=='m'||str.charAt(i)=='+')
	    	 {stbuf.append(',');}
	    	}
	    	}

	    	String res=stbuf.toString();

	    	String [] you = res.split("'.'");
	    	StringBuffer stbuff = new StringBuffer();
	    	for(int i=0;i<you.length;i++)
	    	stbuff.append(you[i]);
	    	StringBuffer st = new StringBuffer();
	    	String resultat=stbuff.toString();
	    	resultat=resultat.replaceAll("\\s+","");
	    	String[] resu = resultat.split(",");
	    	st.append("[[");
	    	    
	    	for (int i = 0; i < resu.length; i++) {
	    		
	    		if(i%8==0  && i!=0){st.append("]");st.append(",");st.append("[");}
	    		else{
	    			if(i%8==0){}
	    		else{st.append(",");}
	    		    }
	    		st.append(resu[i]);
	    		
	    	}
	    	st.append("]]");
	    	
	    		//System.out.println("***"+st.toString());
	    		return st.toString();
		    	

	    	}
	    	System.out.println("*8*8*"+List);
			return null;}
	    //change pieces whith out bored 
	private void updateTablePieces(String List) {

		StringBuffer stb = new StringBuffer();
		
		try {
			for(int i=0;i<List.length();i++){
				if(List.charAt(i)=='[' || List.charAt(i)==']'){}
				else {
				stb.append(List.charAt(i));}		
			}
		} catch (Exception e1) {
			System.out.println(" illegal move ");
			wichturn = 1;
			run();
		}
		
		
		String [] Stock = stb.toString().split(",");
		int j=0; int e=0;
		for(int i=0;i<Stock.length;i++){
			pieces[j][e]= Stock[i];
			e++;
			if(e==8){e=0; j++;}	
		}
		//board.update(pieces, table);
		

	    }
	public String lookkingb(String List){
		String str ;
		String str7 = "checkking("+List+ ",E)";
    	Query q1 = new Query(str7); 
    	Hashtable solution1= new Hashtable();
    	solution1 = q1.oneSolution();

    	str=solution1.get("E").toString();
    	if (str != null){
	    	
	    	char e="'".charAt(0);
	    	char k="(".charAt(0);
	    	char f=")".charAt(0);

	    	char v=",".charAt(0);
	    	char h="[".charAt(0);
	    	char l="]".charAt(0);

	    	StringBuffer stbuf = new StringBuffer();


	    	for(int i=0;i<str.length();i++)
	     	{	
	    	if(str.charAt(i)==k || str.charAt(i)==f || str.charAt(i)==v||str.charAt(i)==h||str.charAt(i)==l)
	    	{} 

	    	else{
	    	stbuf.append(str.charAt(i));
	    	 if(str.charAt(i)=='p' ||str.charAt(i)=='k'||str.charAt(i)=='m'||str.charAt(i)=='+')
	    	 {stbuf.append(',');}
	    	}
	    	}

	    	String res=stbuf.toString();

	    	String [] you = res.split("'.'");
	    	StringBuffer stbuff = new StringBuffer();
	    	for(int i=0;i<you.length;i++)
	    	stbuff.append(you[i]);
	    	StringBuffer st = new StringBuffer();
	    	String resultat=stbuff.toString();
	    	resultat=resultat.replaceAll("\\s+","");
	    	String[] resu = resultat.split(",");
	    	st.append("[[");
	    	    
	    	for (int i = 0; i < resu.length; i++) {
	    		
	    		if(i%8==0  && i!=0){st.append("]");st.append(",");st.append("[");}
	    		else{
	    			if(i%8==0){}
	    		else{st.append(",");}
	    		    }
	    		st.append(resu[i]);
	    		
	    	}
	    	st.append("]]");
	    	

	    		return st.toString();
	    	}else return "";
    	
	}
//*********************************run
    public void run() {
    	
		    	
        turn = true;

        String str;
        while (win==0) {
        	
        	StringBuffer List = new StringBuffer();
	    	List.append("[[");
	    	for(int z=0; z<8; z++){
		    	for(int i=0;i<8;i++){
		    	List.append(pieces[z][i]);
		    	if(i<7)
		    	{List.append(",");}
		    	if(i==7 && z!=7)
		    	{List.append("]");List.append(",");List.append("[");}
		    	                    }
	    	if(z==7)
	    	{List.append("]");List.append("]");}
	    	             }
	    	String List1 = lookkingb(List.toString());
	    	updateTablePieces(List1);
	    	board.update(pieces, table, succ);
            if (turn){
                str = query1;
            }

            else{
                str = query2;
            	}
            
            if (checkWin(List1)) {
    			for(int i = 0; i<8;i++)
    				for(int j = 0 ; j<8;j++)
    					succ[i][j] = 0;
    			board.update(pieces, table, succ);
    			break;
            }
            
            if ((str.equals("callalphabetaw")||str.equals("callalphabetab"))&& wichturn == 2) {
            	//System.out.println("$****callalphabeta****$");
            	
            	String st = Callaphabeta(List1 ,depth)   ;   
            	//System.out.println(st);
                updateTablePieces(st);
					    			for(int i = 0; i<8;i++)
					    				for(int j = 0 ; j<8;j++)
					    					succ[i][j] = 0;
                board.update(pieces, table, succ);
                wichturn = 1;

                }
             else if ((str.equals("doeatw")||str.equals("doeatb"))&& wichturn == 1) {
                
                	String st = make_move(List1);
                    //wait(1000);
                    updateTablePieces(st);
			        			for(int i = 0; i<8;i++)
			        				for(int j = 0 ; j<8;j++)
			        					succ[i][j] = 0;
                    board.update(pieces, table, succ);
                    wichturn = 2 ;

                
            }
          
            //wait(200);
            
            turn = !turn;
        	/*System.out.print("*2*");
        	for (int i = 0 ; i <8;i++)
        		for (int j=0 ; j<8 ; j++)
        			System.out.print(pieces[i][j]);
        	System.out.println();*/
        }}



    public void succpiece(int sx1, int sy1){
		initsucc();
		if (sy != 100 && sx != 100 && pieces[sx-1][sy-1].equals("wp") && pieces[sy1][sx1].equals("em")){
			ex = sy1+1;	
			ey = sx1+1;
			movedone = true;	
		}else { 
			
			if (pieces[sy1][sx1].equals("wp")){
			//System.out.println(pieces[sy1][sx1]);
			sx = sy1+1; // Incrementer ( Prolog)	
			sy = sx1+1;
			System.out.println(sx+" "+sy); 
			
			if(sy>3 && sy<7 && sx<7){
				   if((pieces[sx][sy].equals("bp")||pieces[sx][sy].equals("bk")) && (pieces[sx][sy-2].equals("bp")||pieces[sx][sy-2].equals("bk"))){
					   
					   if(pieces[sx+1][sy+1].equals("em") && pieces[sx+1][sy-3].equals("em")){
				           succ[sx+1][sy+1]=1;
				           succ[sx+1][sy-3]=1;
				           board.update(pieces, table, succ);
				       }       
				   }else{ 
				        if(pieces[sx][sy].equals("bp")||pieces[sx][sy].equals("bk")){
				        	
				             if(pieces[sx+1][sy+1].equals("em")){
				                    succ[sx+1][sy+1]=1;
				                     board.update(pieces, table, succ);
				                                          }
				                                                      }
				       if(pieces[sx][sy-2].equals("bp")||pieces[sx][sy-2].equals("bk")){
				         if(pieces[sx+1][sy-3].equals("em")){
				             succ[sx+1][sy-3]=1;
				             
				             board.update(pieces, table, succ);
				                                      }  
				                                                        }
				       }
				}

				if(sx+2<=8 && sy<3){
					System.out.println(" sx+2<=8 && sy<3");
				    if(pieces[sx][sy].equals("bp")||pieces[sx][sy].equals("bk")){
				        if(pieces[sx+1][sy+1].equals("em")){
				          
				           succ[sx+1][sy+1]=1;
				           board.update(pieces, table, succ);
				                                    }  
				                                                   }
				                    }
				if(sx+2<=8 && sy>6){
					System.out.println("sx+2<=8 && sy>6");
				            if(pieces[sx][sy-2].equals("bp")|| pieces[sx][sy-2].equals("bk")){
				                 if(pieces[sx+1][sy-3].equals("em")){
				                     
				                     succ[sx+1][sy-3]=1;
				                     board.update(pieces, table, succ);
				                                             }  
				                                                                }                       
				         }

			       
		        	
			     if(0<sx && sx<8 && sy==1 && pieces[sx][sy].equals("em")){
					 succ[sx][sy]=1;
				     board.update(pieces, table, succ);
			         
			      } else{
			    	  
			      if(0<sx && sx<8 && sy==8 && pieces[sx][sy-2].equals("em")){
			    		     
							 succ[sx][sy-2]=1;
			    	         board.update(pieces, table, succ);
			    	                                                }
			      else{
			      if(0<sx && sx<8 && 1<sy && sy+1<=8){
			    	  if(pieces[sx][sy-2].equals("em")&& pieces[sx][sy].equals("em")){
			    		 // System.out.println("le milieu "+pieces[sx][sy-2]);
			    		 // System.out.println("le milieu "+pieces[sx][sy]);
			    		     
			    		     succ[sx][sy-2]=1;
			    	         succ[sx][sy]=1;
			    	        
			    	         board.update(pieces, table, succ);
			    	  } else{
			    	       if(pieces[sx][sy-2].equals("em")){
			    	    	   
							 succ[sx][sy-2]=1;
							// System.out.println(succ[sx][sy-2]);
							 board.update(pieces, table, succ);
			    	         
			    	      } 
			    	     if(pieces[sx][sy].equals("em")){
			    	    	//  System.out.println("le milieu "+pieces[sx][sy]);
			    		     
							 succ[sx][sy]=1;
							// System.out.println(succ[sx][sy]);
			    	         board.update(pieces, table, succ);
			    	                                       }
			    	        }
			    	  }
			      }
			      }
			      
			      
			/*
			if ( (sy+1<8 && sy-3>=0)&& (pieces[sx][sy-2].equals("bp") || pieces[sx][sy-2].equals("bk")) &&(pieces[sx][sy].equals("bp" )|| pieces[sx][sy].equals("bk")) ){
				if( pieces[sx+1][sy+1].equals("em") &&  pieces[sx+1][sy-3].equals("em")){
					succ[sx+1][sy+1]=1;
					succ[sx+1][sy-3]=1;

				}
			}
			 if ( (sy<8 && sy-2>=0) && (pieces[sx][sy-2].equals("bp") || pieces[sx][sy-2].equals("bk")) &&pieces[sx][sy].equals("em") ){
				if( sy-3 >= 0 && pieces[sx+1][sy-3].equals("em")){
					succ[sx+1][sy-3]=1;
					succ[sx][sy]=1;
				}
			}
			if ( (sy<8 && sy-2>=0) && (pieces[sx][sy].equals("bp" )|| pieces[sx][sy].equals("bk")) && pieces[sx][sy-2].equals("em") ) {
				if(sy+1 <8 && pieces[sx+1][sy+1].equals("em")){
					succ[sx+1][sy+1]=1;
					succ[sx][sy-2]=1;
					}
			}
			if ((sy<8 && sy-2>=0) && pieces[sx][sy-2].equals("em") && pieces[sx][sy].equals("em")  ){
				succ[sx][sy-2]=1;
				succ[sx][sy]=1;
			}
			if (sy-2<0 && (pieces[sx][sy].equals("bp") || pieces[sx][sy].equals("bk"))){
				if(sy+1 <8 && pieces[sx+1][sy+1].equals("em")){
					succ[sx+1][sy+1]=1;
					//System.out.println(pieces[sy1+1][sx1-1]);
					}
			}
			if(sy-2<0 && pieces[sx][sy].equals("em")){
				succ[sx][sy]=1;
			}
			
			if (sy==8 &&   pieces[sx][sy-2].equals("em")){				
				
					//System.out.println(pieces[sx][sy-2]);
					succ[sx][sy-2]=1;					
				
			}
			
			if (( sy-2>=0 && sy<8 && pieces[sx][sy-2].equals("bp") && sy-3 >= 0 && pieces[sx+1][sy-3].equals("em"))|| ( sy-2>=0 && sy-3 >= 0 && pieces[sx+1][sy-3].equals("em") && pieces[sx][sy-2].equals("bk"))){
					
						succ[sx+1][sy-3]=1;
			} */
			
		
			
				//System.out.println(sx+" "+(sy-2));
			//board.update(pieces, table, succ);
			
			
			}
			
			if (sy != 100 && sx != 100 && pieces[sx-1][sy-1].equals("wk") && pieces[sy1][sx1].equals("em")){
			ex = sy1+1;	
			ey = sx1+1;
			movedone = true;	
		   }else if (pieces[sy1][sx1].equals("wk")){
			sx = sy1+1; // Incrementer ( Prolog)	
			sy = sx1+1;
			
			if(sx==1 && sy<7){
			    if(pieces[sx][sy].equals("bk") ||pieces[sx][sy].equals("bp")){
			        if(pieces[sx+1][sy+1].equals("em")){
			            succ[sx+1][sy+1]=1;
			             board.update(pieces, table, succ);
			        }
			    }
			}

			if(sx==8 && sy<7){
			    if(pieces[sx-2][sy].equals("bk") ||pieces[sx-2][sy].equals("bp")){
			        if(pieces[sx-3][sy+1].equals("em")){
			            succ[sx-3][sy+1]=1;
			             board.update(pieces, table, succ);
			        }
			    }
			}

			if(sx==1  && sy==8){
			     if(pieces[sx][sy-2].equals("bk") ||pieces[sx][sy-2].equals("bp")){
			        if(pieces[sx+1][sy-3].equals("em")){
			            succ[sx+1][sy-3]=1;
			             board.update(pieces, table, succ);
			        }
			    }
			}

			if(sx==8  && sy==8){
			     if(pieces[sx-2][sy-2].equals("bk") ||pieces[sx-2][sy-2].equals("bp")){
			        if(pieces[sx-3][sy-3].equals("em")){
			            succ[sx-3][sy-3]=1;
			             board.update(pieces, table, succ);
			        }
			    }
			}

			if(sy>2 && sy<7 && sx<7){
			    if((pieces[sx][sy].equals("bk") ||pieces[sx][sy].equals("bp")) && (pieces[sx][sy-2].equals("bk") ||pieces[sx][sy-2].equals("bp"))){
			         if(pieces[sx+1][sy+1].equals("em") && pieces[sx+1][sy-3].equals("em")){
			            succ[sx+1][sy-3]=1;
			            succ[sx+1][sy+1]=1;
			             board.update(pieces, table, succ);
			        }

			    }
			    if(pieces[sx][sy].equals("bk") ||pieces[sx][sy].equals("bp")){
			        if(pieces[sx+1][sy+1].equals("em")){
			             succ[sx+1][sy+1]=1;
			              board.update(pieces, table, succ);
			        }
			    }
			      if(pieces[sx][sy-2].equals("bk") ||pieces[sx][sy-2].equals("bp")){
			        if(pieces[sx+1][sy-3].equals("em")){
			             succ[sx+1][sy-3]=1;
			              board.update(pieces, table, succ);
			        }
			    }
			}

			if(sy>2 && sy<7 && sx==8){
			    if((pieces[sx-2][sy].equals("bk") ||pieces[sx-2][sy].equals("bp")) && (pieces[sx-2][sy-2].equals("bk") ||pieces[sx-2][sy-2].equals("bp"))){
			         if(pieces[sx-3][sy+1].equals("em") && pieces[sx-3][sy-3].equals("em")){
			            succ[sx-3][sy-3]=1;
			            succ[sx-3][sy+1]=1;
			             board.update(pieces, table, succ);
			        }

			    }
			    if(pieces[sx-2][sy].equals("bk") ||pieces[sx-2][sy].equals("bp")){
			        if(pieces[sx-3][sy+1].equals("em")){
			             succ[sx-3][sy+1]=1;
			              board.update(pieces, table, succ);
			        }
			    }
			      if(pieces[sx-2][sy-2].equals("bk") ||pieces[sx-2][sy-2].equals("bp")){
			        if(pieces[sx-3][sy-3].equals("em")){
			             succ[sx-3][sy-3]=1;
			              board.update(pieces, table, succ);
			        }
			    }

			}

			if(sx>2 && sx<7 && sy>2 && sy<7){
			    if((pieces[sx-2][sy].equals("bk") ||pieces[sx-2][sy].equals("bp")) && (pieces[sx-2][sy-2].equals("bk") ||pieces[sx-2][sy-2].equals("bp")) && (pieces[sx][sy].equals("bk") ||pieces[sx][sy].equals("bp")) && (pieces[sx][sy-2].equals("bk") ||pieces[sx][sy-2].equals("bp"))){
			       if(pieces[sx+1][sy+1].equals("em") && pieces[sx+1][sy-3].equals("em") && pieces[sx-3][sy+1].equals("em") && pieces[sx-3][sy-3].equals("em")){
			                       succ[sx+1][sy-3]=1;
			                       succ[sx+1][sy+1]=1;
			                       succ[sx-3][sy-3]=1;
			                       succ[sx-3][sy+1]=1;
			                        board.update(pieces, table, succ);
			       }
			    }

			    if((pieces[sx][sy].equals("bk") ||pieces[sx][sy].equals("bp")) && (pieces[sx][sy-2].equals("bk") ||pieces[sx][sy-2].equals("bp"))){
			       if(pieces[sx+1][sy+1].equals("em") && pieces[sx+1][sy-3].equals("em")){
			                      succ[sx+1][sy-3]=1;
			                       succ[sx+1][sy+1]=1;
			                        board.update(pieces, table, succ);
			       }
			    }

			    if((pieces[sx-2][sy].equals("bk") ||pieces[sx-2][sy].equals("bp")) && (pieces[sx-2][sy-2].equals("bk") ||pieces[sx-2][sy-2].equals("bp"))){
			       if(pieces[sx-3][sy+1].equals("em") && pieces[sx-3][sy-3].equals("em")){
			                      succ[sx-3][sy-3]=1;
			                      succ[sx-3][sy+1]=1;
			                       board.update(pieces, table, succ);
			       }
			    }

			    if((pieces[sx][sy].equals("bk") ||pieces[sx][sy].equals("bp")) && (pieces[sx-2][sy].equals("bk") ||pieces[sx-2][sy].equals("bp"))){
			        if(pieces[sx+1][sy+1].equals("em") && pieces[sx-3][sy+1].equals("em")){
			                        succ[sx+1][sy+1]=1;
			                        succ[sx-3][sy+1]=1;
			                         board.update(pieces, table, succ);
			        }
			    }

			    if((pieces[sx][sy-2].equals("bk") ||pieces[sx][sy-2].equals("bp")) && (pieces[sx-2][sy-2].equals("bk") ||pieces[sx-2][sy-2].equals("bp"))){
			        if(pieces[sx+1][sy-3].equals("em") && pieces[sx-3][sy-3].equals("em")){
			                      succ[sx+1][sy-3]=1;
			                      succ[sx-3][sy-3]=1;
			                       board.update(pieces, table, succ);

			        }
			    }

			    if((pieces[sx][sy].equals("bk") ||pieces[sx][sy].equals("bp")) && (pieces[sx-2][sy-2].equals("bk") ||pieces[sx-2][sy-2].equals("bp"))){
			        if(pieces[sx+1][sy+1].equals("em") && pieces[sx-3][sy-3].equals("em")){
			                     succ[sx+1][sy+1]=1;
			                      succ[sx-3][sy-3]=1;
			                       board.update(pieces, table, succ);
			        }

			    }
			    if((pieces[sx][sy-2].equals("bk") ||pieces[sx][sy-2].equals("bp")) && (pieces[sx-2][sy].equals("bk") ||pieces[sx-2][sy].equals("bp"))){
			        if(pieces[sx+1][sy-3].equals("em") &&  pieces[sx-3][sy+1].equals("em")){
			            succ[sx+1][sy-3]=1;
			            succ[sx-3][sy+1]=1;
			             board.update(pieces, table, succ);
			        }
			    }

			if((pieces[sx][sy].equals("bk") ||pieces[sx][sy].equals("bp")) &&  (pieces[sx-2][sy].equals("bk") ||pieces[sx-2][sy].equals("bp")) && (pieces[sx][sy-2].equals("bk") ||pieces[sx][sy-2].equals("bp"))){
			       if(pieces[sx+1][sy+1].equals("em") && pieces[sx+1][sy-3].equals("em") && pieces[sx-3][sy+1].equals("em") ){
			                      succ[sx+1][sy-3]=1;
			                       succ[sx+1][sy+1]=1;
			                       succ[sx-3][sy+1]=1;
			                       board.update(pieces, table, succ);
			       }
			    }
			if((pieces[sx][sy].equals("bk") ||pieces[sx][sy].equals("bp")) &&  (pieces[sx-2][sy-2].equals("bk") ||pieces[sx-2][sy-2].equals("bp")) && (pieces[sx][sy-2].equals("bk") ||pieces[sx][sy-2].equals("bp"))){
			       if(pieces[sx+1][sy+1].equals("em") && pieces[sx+1][sy-3].equals("em") && pieces[sx-3][sy-3].equals("em") ){
			                       succ[sx+1][sy-3]=1;
			                       succ[sx+1][sy+1]=1;
			                       succ[sx-3][sy-3]=1;
			                        board.update(pieces, table, succ);
			       }
			    }


			 if((pieces[sx-2][sy].equals("bk") ||pieces[sx-2][sy].equals("bp")) && (pieces[sx][sy].equals("bk") ||pieces[sx][sy].equals("bp")) && (pieces[sx-2][sy-2].equals("bk") ||pieces[sx-2][sy-2].equals("bp"))){
			       if(pieces[sx-3][sy+1].equals("em") && pieces[sx-3][sy-3].equals("em") && pieces[sx+1][sy+1].equals("em")){
			                      succ[sx-3][sy-3]=1;
			                      succ[sx-3][sy+1]=1;
			                      succ[sx+1][sy+1]=1;
			                       board.update(pieces, table, succ);
			       }
			    }

			 if((pieces[sx-2][sy].equals("bk") ||pieces[sx-2][sy].equals("bp")) && (pieces[sx][sy-2].equals("bk") ||pieces[sx][sy-2].equals("bp")) && (pieces[sx-2][sy-2].equals("bk") ||pieces[sx-2][sy-2].equals("bp"))){
			       if(pieces[sx-3][sy+1].equals("em") && pieces[sx-3][sy-3].equals("em") && pieces[sx+1][sy+1].equals("em")){
			                      succ[sx-3][sy+1]=1;
			                      succ[sx+1][sy-3]=1;
			                      succ[sx-3][sy-3]=1;
			                       board.update(pieces, table, succ);
			       }
			    }

			    if(pieces[sx-2][sy].equals("bk") ||pieces[sx-2][sy].equals("bp")){
			        if(pieces[sx-3][sy+1].equals("em")){
			            succ[sx-3][sy+1]=1;
			             board.update(pieces, table, succ);
			        }
			    }

			    if(pieces[sx][sy].equals("bk") ||pieces[sx][sy].equals("bp")){
			        if(pieces[sx+1][sy+1].equals("em")){
			            succ[sx+1][sy+1]=1;
			             board.update(pieces, table, succ);
			        }
			    }

			    if(pieces[sx-2][sy-2].equals("bk") ||pieces[sx-2][sy-2].equals("bp")){
			        if(pieces[sx-3][sy-3].equals("em")){
			            succ[sx-3][sy-3]=1;
			             board.update(pieces, table, succ);
			        }
			    }
			    if(pieces[sx][sy-2].equals("bk") ||pieces[sx][sy-2].equals("bp")){
			        if(pieces[sx+1][sy-3].equals("em")){
			            succ[sx+1][sy-3]=1;
			             board.update(pieces, table, succ);
			        }
			    }



			}
			if(sy==1 && sx<8 && sx>1){
			    if(pieces[sx][sy].equals("em") && pieces[sx-2][sy].equals("em")){
			        succ[sx][sy]=1;
			        succ[sx-2][sy]=1;
			        board.update(pieces, table, succ);
			    }
			    if(pieces[sx][sy].equals("em")){
			        succ[sx][sy]=1;
			        board.update(pieces, table, succ);
			    }
			    if(pieces[sx-2][sy].equals("em")){
			        succ[sx-2][sy]=1;
			        board.update(pieces, table, succ);
			    }
			}

            if(sx==8 && sy<8 && sy>1){
            	if(pieces[sx-2][sy-2].equals("em") && pieces[sx-2][sy].equals("em")){
            		succ[sx-2][sy-2]=1;
            		succ[sx-2][sy]=1;
            		board.update(pieces, table, succ);
            	}
            	if(pieces[sx-2][sy-2].equals("em")){
            		succ[sx-2][sy-2]=1;
            		board.update(pieces, table, succ);
            		}
            	if(pieces[sx-2][sy].equals("em")){
            		succ[sx-2][sy]=1;
            		board.update(pieces, table, succ);
            		}
            }
            if(sx==8 && sy==1){
            	if(pieces[sx-2][sy].equals("em")){
            	succ[sx-2][sy]=1;
            	 board.update(pieces, table, succ);
            	}
            }
            if(sx==8 && sy==8){
            	if(pieces[sx-2][sy-2].equals("em")){
            	succ[sx-2][sy-2]=1;
            	 board.update(pieces, table, succ);
            	}
            }
            

			if(sy==1 && sx==1){
			     if(pieces[sx][sy].equals("em")){
			      succ[sx][sy]=1;
			      board.update(pieces, table, succ);
			     }
			}
			 if(sy==8 && sx<8 && sx>1){
			      if(pieces[sx][sy-2].equals("em") && pieces[sx-2][sy-2].equals("em")){
			        succ[sx][sy-2]=1;
			        succ[sx-2][sy-2]=1;
			        board.update(pieces, table, succ);
			      }
			      if(pieces[sx][sy-2].equals("em")){
			          succ[sx][sy-2]=1;
			          board.update(pieces, table, succ);
			      }
			        if(pieces[sx-2][sy-2].equals("em")){
			          succ[sx-2][sy-2]=1;
			          board.update(pieces, table, succ);
			      }

			 }
			 if(sx<8 && sx>1 && sy>1 && sy<8){
			     if(pieces[sx][sy-2].equals("em") && pieces[sx-2][sy-2].equals("em") && pieces[sx][sy].equals("em") && pieces[sx-2][sy].equals("em")){
			         succ[sx][sy-2]=1;
			         succ[sx][sy]=1;
			         succ[sx-2][sy-2]=1;
			         succ[sx-1][sy]=1;
			         board.update(pieces, table, succ);
			     }
			      if(pieces[sx][sy-2].equals("em") && pieces[sx-2][sy-2].equals("em")){
			        succ[sx][sy-2]=1;
			        succ[sx-2][sy-2]=1;
			        board.update(pieces, table, succ);
			      }
			       if(pieces[sx][sy].equals("em") && pieces[sx-2][sy].equals("em")){
			        succ[sx][sy]=1;
			        succ[sx-2][sy]=1;
			        board.update(pieces, table, succ);
			    }
			     if(pieces[sx-2][sy].equals("em") && pieces[sx-2][sy-2].equals("em")){
			        succ[sx-2][sy]=1;
			        succ[sx-2][sy-2]=1;
			        board.update(pieces, table, succ);
			    }
			    if(pieces[sx][sy].equals("em") && pieces[sx][sy-2].equals("em")){
			        succ[sx][sy]=1;
			        succ[sx][sy-2]=1;
			        board.update(pieces, table, succ);
			    }
			     if(pieces[sx][sy].equals("em") && pieces[sx-2][sy-2].equals("em")){
			        succ[sx][sy]=1;
			        succ[sx-2][sy-2]=1;
			        board.update(pieces, table, succ);
			    }
			     if(pieces[sx][sy].equals("em") && pieces[sx][sy-2].equals("em") &&  pieces[sx-2][sy].equals("em")){
			        succ[sx][sy]=1;
			        succ[sx][sy-2]=1;
			        succ[sx-2][sy]=1;
			        board.update(pieces, table, succ);
			    }
			    if(pieces[sx][sy].equals("em") && pieces[sx-2][sy-2].equals("em") && pieces[sx][sy-2].equals("em")){
			        succ[sx][sy]=1;
			        succ[sx-2][sy-2]=1;
			        succ[sx][sy-2]=1;
			        board.update(pieces, table, succ);
			    }
			    if(pieces[sx][sy].equals("em")){
			        succ[sx][sy]=1;
			        board.update(pieces, table, succ);
			        }

			    if(pieces[sx][sy-2].equals("em")){
			        succ[sx][sy-2]=1;
			        board.update(pieces, table, succ);
			        }

			    if(pieces[sx-2][sy].equals("em")){
			        succ[sx-2][sy]=1;
			        board.update(pieces, table, succ);
			        }
			    if(pieces[sx-2][sy-2].equals("em")){
			        succ[sx-2][sy-2]=1;
			        board.update(pieces, table, succ);
			        }

			 }
			} 
		
		
		}
	}
    private void wait(int waiting) {
        try {
            Thread.sleep(waiting/4); //1000 milliseconds is one second.
        } catch (InterruptedException ex) {
            Thread.currentThread().interrupt();
        }
    }
    


}