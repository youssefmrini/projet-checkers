import java.awt.Color;
import java.awt.Cursor;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.Point;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.MouseMotionListener;
import java.util.HashMap;
import java.util.Map;
import javax.swing.JOptionPane;
import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;

public class Board extends JFrame {

    static final int N = 8;
    private JLabel[] labelsWhite = new JLabel[20];
    private JLabel[] labelsBlack = new JLabel[20];
    private ImageIcon black, white,whitequeen,blackqueen;
    private JPanel canvasBoard;
    private int clicked;
    private Point start,end;
    private String[][] table;
    private String[][]  pieces;
    private int [][] succ;
    private Game game;



	public Board(String[][] table, String[][] pieces,int[][]succ, Game game) {
		// TODO Auto-generated constructor stub*
	       this.table = table;
	        this.pieces= pieces;
	        this.succ = succ;
	        this.game=game;
	        clicked=0;
	        configure();
	        createAndShowGUI();
	}


	private void createAndShowGUI() {
        setTitle("Board");

        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);

        this.addWindowListener(new java.awt.event.WindowAdapter() {
            @Override
            public void windowClosing(java.awt.event.WindowEvent windowEvent) {
                game.m.stop();
            }
        });

        addComponentsToPane();

        setSize(500, 500);
        setLocationRelativeTo(null);
        setVisible(true);
    }

    private void configure() {
        black = new ImageIcon("Photos/black.png");
        Image img = black.getImage();
        Image newimgblack = img.getScaledInstance(36, 36, java.awt.Image.SCALE_SMOOTH);
        black = new ImageIcon(newimgblack);
        white = new ImageIcon("Photos/white.png");
        img = white.getImage();
        Image newimgwhite = img.getScaledInstance(36, 36, java.awt.Image.SCALE_SMOOTH);
        white = new ImageIcon(newimgwhite);
        whitequeen = new ImageIcon("Photos/white_queen.png");
        img = whitequeen.getImage();
        Image newimgwhitequeen = img.getScaledInstance(36, 36, java.awt.Image.SCALE_SMOOTH);
        whitequeen = new ImageIcon(newimgwhitequeen);
        blackqueen = new ImageIcon("Photos/black_queen.png");
        img = blackqueen.getImage();
        Image newimgblackqueen = img.getScaledInstance(36, 36, java.awt.Image.SCALE_SMOOTH);
        blackqueen = new ImageIcon(newimgblackqueen);
    }

    private void addComponentsToPane() {
        canvasBoard=new CanvasBoard();
        canvasBoard.addMouseMotionListener(new MouseMotionListener() {
            @Override
            public void mouseMoved(MouseEvent e) {
                Point p = e.getPoint();
                int x = 40,y = 20,distx = 50,disty = 50;
                int ex=(int)((p.getX()-x)/distx);
                int ey=(int)((-p.getY()+420)/disty);
                if(ex>=0 && ex<=7 && ey>=0 && ey<=7){
                    if(pieces[ey][ex]!="+"){
                        Cursor cursor = Cursor.getPredefinedCursor(Cursor.HAND_CURSOR);
                        setCursor(cursor);
                    } else {
                        Cursor cursor = Cursor.getDefaultCursor();
                        setCursor(cursor);
                    }
                }
            }
            @Override
            public void mouseDragged(MouseEvent e) {}
        });
        canvasBoard.addMouseListener(new MouseListener() {
            @Override
            public void mouseReleased(MouseEvent e) {
            }
            @Override
            public void mousePressed(MouseEvent e) {
            }
            @Override
            public void mouseExited(MouseEvent e) {
            }
            @Override
            public void mouseEntered(MouseEvent e) {
            }
            @Override
            public void mouseClicked(MouseEvent e) {
                Point p = e.getPoint();
                int x = 40,y = 20,distx = 50,disty = 50;
                if(clicked==0){
                	start=p;
                	
                }
                start=p;
                    int sx=(int)((start.getX()-x)/distx);
                    int sy=(int)((-start.getY()+420)/disty);
                    	game.succpiece(sx,sy);
                    
                        //game.sendQuery(sx,sy,ex,ey);
                
                
                
            }
        });
        getContentPane().add(canvasBoard);
    }

    public void update(String[][] pieces,String[][] table, int[][]succ) {
        this.table=table;
        this.pieces=pieces;
        this.succ = succ;
        canvasBoard.repaint();
        
    }

    class CanvasBoard extends JPanel {
    	
        @Override
        protected void paintComponent(Graphics g) {
            super.paintComponent(g);
            Graphics2D g2d = (Graphics2D) g;
            int x = 40,y = 20,distx = 50,disty = 50;
            for (int i = N-1; i >=0; --i) {
                x = 40;
                //table[][]  
                for (int j = 0; j < N; ++j) {
                    if (table[i][j]=="+") {
                        g2d.setColor(new Color(255, 255, 255));
                    } else if((table[i][j]== "wp" || table[i][j]=="em" || table[i][j]=="bp" ||table[i][j]=="wk" || table[i][j]=="bk") && succ[i][j]==1 ){
                        g2d.setColor(new Color(85 ,85 ,85));
                    } else if(table[i][j]=="em"){
                        g2d.setColor(new Color(0, 0, 0));
                    }
                    g2d.fillRect(x, y, distx, disty);
                    g2d.setColor(Color.black);
                    g2d.drawRect(x, y, distx, disty);
                    x+=distx;
                }
                y+= disty;
            }
           
                
            x = 20;
            y = 50;
            for (int i = 0; i < N; ++i) {
                String s = String.valueOf(8 - i);
                g2d.drawString(s, x, y);
                y += disty;
            }
            x = 8 + distx;
            y -= 8;
            for (int i = 0; i < N; ++i) {
                String s = String.valueOf(i + 1);
                g2d.drawString(s, x, y);
                x += distx;
            }
            x = 40;
            y = 20;
            distx = 50;
            disty = 50;
            
            
            for (int i = N - 1; i >= 0; --i) {
                x = 40;
                for (int j = 0; j < N; ++j) {
                	
                    if (pieces[i][j].equals( "wp")) {
                        g2d.drawImage(white.getImage(), x + 7, y + 7, 36, 36, null);
                    } else if (pieces[i][j].equals("bp")) {
                        g2d.drawImage(black.getImage(), x + 7, y + 7, 36, 36, null);

                    } else if (pieces[i][j].equals("wk")) {
                        g2d.drawImage(whitequeen.getImage(), x + 7, y + 7, 36, 36, null);
                    } else if (pieces[i][j].equals("bk")) {
                        g2d.drawImage(blackqueen.getImage(), x + 7, y + 7, 36, 36, null);
                    }
                    x += distx;
                }
                y += disty;
            }
        }
    }

}