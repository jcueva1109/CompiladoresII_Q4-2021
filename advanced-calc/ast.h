#ifndef _AST_H_
#define _AST_H_

#include <list>
#include <string>
using namespace std;

class Expr;
class Statement;
typedef list<Expr*> ExprList;
typedef list<Statement*> StmtList;

class Expr{

    public: 
        virtual float eval() = 0;

};

enum StatementKind{

    WHILE_STATEMENT

};

class Statement{

    public:
        virtual float evalSemantic() = 0;
        virtual StatementKind getKind() = 0;

};

class BinaryExpr: public Expr{

    public: 
        BinaryExpr(Expr* expr1, Expr* expr2){
            this->expr1 = expr1;
            this->expr2 = expr2;
        }

        Expr* expr1;
        Expr* expr2;

};

class AddExpr: public BinaryExpr{

    public:
        AddExpr(Expr* expr1, Expr* expr2): BinaryExpr(expr1, expr2){  }

    float eval();

};

class SubExpr: public BinaryExpr{

    public:
        SubExpr(Expr* expr1, Expr* expr2): BinaryExpr(expr1, expr2){  }

    float eval();

};

class MulExpr: public BinaryExpr{

    public:
        MulExpr(Expr* expr1, Expr* expr2): BinaryExpr(expr1, expr2){  }

    float eval();

};

class DivExpr: public BinaryExpr{

    public:
        DivExpr(Expr* expr1, Expr* expr2): BinaryExpr(expr1, expr2){  }

    float eval();

};

class NumExpr: public Expr{

    public:
        NumExpr(float number){
            this->number = number;
        }

    float number;
    float eval();

};

class WhileStatement: public Statement{

    public:
        WhileStatement(Expr* expr, Statement* stmt){

            this->expr = expr;
            this->stmt = stmt;

        }
        Expr* expr;
        Statement* stmt;
        StatementKind getKind(){
            return WHILE_STATEMENT;
        }
};

#endif