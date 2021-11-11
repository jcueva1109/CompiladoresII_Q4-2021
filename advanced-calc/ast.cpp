#include "ast.h"
#include <map>
#include <iostream>

float NumExpr::eval(){

    return this->number;

}

float AddExpr::eval(){
    
    return this->expr1->eval() + this->expr2->eval();

}

float SubExpr::eval(){

    return this->expr1->eval() - this->expr2->eval();

}

float MulExpr::eval(){

    return this->expr1->eval() * this->expr2->eval();

}

float DivExpr::eval(){

    return this->expr1->eval() / this->expr2->eval();

}

