import java.awt.Font;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.ButtonGroup;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JRadioButton;
import javax.swing.JTextField;
import javax.swing.border.Border;

public class Menu extends JFrame{

    static final int SIZE=6;    
    JButton start;
    JButton left[]=new JButton[SIZE];
    JButton right[]=new JButton[SIZE];
    JTextField center[]= new JTextField[3];
    JRadioButton light[]= new JRadioButton[3];
    ButtonGroup group = new ButtonGroup();
    public static int d=3;
    

    public Menu() {
        createAndShowGUI();//call method to create gui
    }

    private void createAndShowGUI() {
    	 setTitle("jeu de dame");

         setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
     
         JPanel panel=new JPanel();
         panel.setBounds(500, 500, 200, 100);
         panel.setLayout(null);
        
        start = new JButton("Start");
        left[0] = new JButton("User");
        right[0]= new JButton("IA AlphaBeta");
        //right[0] = new JButton("User");
        //left[1] = new JButton("IA AlphaBeta");
        //right[1] = new JButton("IA AlphaBeta");
        center[0]= new JTextField(""){
            @Override public void setBorder(Border border) {
                // No!
            }
        };
        center[1]= new JTextField("VS"){
            @Override public void setBorder(Border border) {
                // No!
            }
        };
        center[2]= new JTextField(""){
            @Override public void setBorder(Border border) {
                // No!
            }
        };;
        
        light[0]= new JRadioButton("Amateur");
        light[1] = new JRadioButton("Normale");
        light[2]= new JRadioButton("Expert");
  
            

        light[0].addActionListener(new Listenera());
        light[1].addActionListener(new Listenern());
        light[2].addActionListener(new Listeners());
        

//        light[0].setBounds(200,150, 120,50);
        group.add(light[0]);
        group.add(light[1]);
        group.add(light[2]);
        light[0].setBounds(40,390,100,40);
        light[1].setBounds(170,390,100,40);
        light[2].setBounds(300,390,100,40);
        

        panel.add(light[0]);
        panel.add(light[1]);
        panel.add(light[2]);

        
        start.setBounds(160,300,150,50);
         start.addActionListener(new ListenerStart());
         left[0].setBounds(10,150,120,40);
        // left[1].setBounds(10,170,120,40);
         left[0].addActionListener(new ListenerLeft());
         //left[1].addActionListener(new ListenerLeft());
         right[0].setBounds(350,150,120,40);
         //right[1].setBounds(350,170,120,40);
         right[0].addActionListener(new ListenerRight());
         //right[1].addActionListener(new ListenerRight());
         center[0].setBounds(90,230,120,60);
         center[0].setHorizontalAlignment(JTextField.CENTER);
         center[0].setEditable(false);
         center[1].setBounds(210,230,60,60);
         center[1].setHorizontalAlignment(JTextField.CENTER);
         center[1].setEditable(false);
         center[2].setBounds(290,230,120,60);
         center[2].setHorizontalAlignment(JTextField.CENTER);
         center[2].setEditable(false);

        Font font = center[0].getFont();
        Font boldFont = new Font(font.getFontName(), Font.BOLD, font.getSize()+4);
        center[0].setFont(boldFont);
        center[1].setFont(boldFont);
        center[2].setFont(boldFont);
        panel.add(start);
        for(int i=0;i<1;++i) {
            panel.add(left[i]);
            panel.add(right[i]);}
        for(int i=0;i<3;++i) {
            
                center[i].setOpaque(false);
                panel.add(center[i]);
            }
        
        add(panel);
        
        setSize(500, 500);
        setLocationRelativeTo(null); 
        setVisible(true);
    }
    
    private class ListenerLeft implements ActionListener{
         public void actionPerformed(ActionEvent e) {
             center[0].setText(e.getActionCommand());
        }
    }
    private class ListenerRight implements ActionListener{
        public void actionPerformed(ActionEvent e){
            center[2].setText(e.getActionCommand());
        }
    }
    private class Listenern implements ActionListener{
        public void actionPerformed(ActionEvent e) {
        	if(e.getActionCommand().toString().equals("Normale")){

                d=2;
              //  System.out.println(d);
            }

        	
        	
       }


		
   }
   private class Listenera implements ActionListener{
       public void actionPerformed(ActionEvent e){
    	   if(e.getActionCommand().toString().equals("Amateur")){
               d=1;
              // System.out.println(d);

           }
       }


   }
   
   private class Listeners implements ActionListener{
       public void actionPerformed(ActionEvent e){
           if(e.getActionCommand().toString().equals("Expert")){
               d=3;
               //System.out.println(d);
           }
       }

   }
   
    private class ListenerStart implements ActionListener{
        public void actionPerformed(ActionEvent e){
            if(!(center[0].getText().equals("") || center[2].getText().equals(""))) {
                Game runnable = new Game(center[0].getText(),center[2].getText());
                Thread game=new Thread(runnable);
                runnable.set_mother(game);
                game.start();
            }
        }
    }
}
