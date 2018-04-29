/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mojica.alexander.mvc;

/**
 *
 * @author MekakuZero
 */
public interface Item {
    public static Item getDefault(String name){
        return new Item(){
            @Override
            public String getName() {
                return name;
            }

            @Override
            public int getValue() {
                return -1;
            }
        };
    }
    public String getName();
    public int getValue();
}
