/*移動するたびに移動可能な場所が変更される迷路*/

func make_board(board_info:inout[[Int]],x:Int){    //迷路の初期生成を行う関数
    for i in 0...x+1{
        for j in 0...x+1{
            if(i==0 || i==x+1 || j==0 || j==x+1){
                board_info[i][j]=2           //周囲の壁(行けない所)の設定
            }else if(i==1 && j==1){
                board_info[i][j]=0           //自分の現在地の初期設定
            }else if(i==x && j==x){
                board_info[i][j]=9           //ゴールの設定
            }else{
                board_info[i][j]=Int.random(in:1...2)    //移動可能マスと移動不可マス(壁)の初期設定
            }
        }
    }
}

func print_board(board_info:[[Int]],board:inout String,x:Int){   //迷路の表示を行う関数
    var board_prt=Array(board)
    for i in 0...x+1{
       for j in 0...x+1{
            if(board_info[i][j]==0){
                board_prt[j]="○"    //自分の現在地の表示
            }else if(board_info[i][j]==9){
                board_prt[j]="●"    //ゴールの表示
            }else if(board_info[i][j]==1){
                board_prt[j]="⋆"    //移動可能マスの表示
            }else{
                board_prt[j]="■"    //移動不可マス(壁)の表示
            }
        }
        board=String(board_prt)
        print(board)            //迷路全体の表示
    }
    print("\n")
}

//移動予定先が移動可能マスかどうかを調べる関数
func check_board(_ to:Int,board_info:[[Int]],x:Int)->Int{
    var I=0
    var J=0
    for i in 1...x{
        for j in 1...x{
            if(board_info[i][j]==0){
                I=i
                J=j
            }
        }
    }
    
    switch(to){
        case 1 :                    //上に移動できるか
            if(board_info[I-1][J]==1){
                return 1            //移動可能
            }else if(board_info[I-1][J]==9){
                return 2            //移動先がゴール
            }else{
                return 0            //移動不可(移動予定先が壁)
            }
        
        case 2 :                    //下に移動できるか
            if(board_info[I+1][J]==1){
                return 1            //移動可能
            }else if(board_info[I+1][J]==9){
                return 2            //移動先がゴール
            }else{
                return 0            //移動不可(移動予定先が壁)
            }
        
        case 3 :                    //右に移動できるか
            if(board_info[I][J+1]==1){
                return 1            //移動可能
            }else if(board_info[I][J+1]==9){
                return 2            //移動先がゴール
            }else{
                return 0            //移動不可(移動予定先が壁)
            }
        
        case 4 :                    //左に移動できるか
            if(board_info[I][J-1]==1){
                return 1            //移動可能
            }else if(board_info[I][J-1]==9){
                return 2            //移動先がゴール
            }else{
                return 0            //移動不可(移動予定先が壁)
            }
        
        case 5 :                    //右上に移動できるか
        //右上に移動する場合、上または右が移動可能マスでなければならない
        
            if(board_info[I-1][J]==1 || board_info[I][J+1]==1){   //上または右が移動可能
                if(board_info[I-1][J+1]==1){
                    return 1        //移動可能
                }else if(board_info[I-1][J+1]==9){
                    return 2        //移動先がゴール
                }else{
                    return 0        //移動不可(移動予定先が壁)
                }
            }else{                  //上も右も移動不可
                return 0            //移動不可(移動予定先が壁)
            }
        
        case 6 :                    //右下に移動できるか
        //右下に移動する場合、下または右が移動可能マスでなければならない
        
            if(board_info[I+1][J]==1 || board_info[I][J+1]==1){   //下または右が移動可能
                if(board_info[I+1][J+1]==1){
                    return 1        //移動可能
                }else if(board_info[I+1][J+1]==9){
                    return 2        //移動先がゴール
                }else{
                    return 0        //移動不可(移動予定先が壁)
                }
            }else{                  //下も右も移動不可
                return 0            //移動不可(移動予定先が壁)
            }
        
        case 7 :                    //左上に移動できるか
        //左上に移動する場合、上または左が移動可能マスでなければならない
        
            if(board_info[I-1][J]==1 || board_info[I][J-1]==1){   //上または左が移動可能
                if(board_info[I-1][J-1]==1){
                    return 1        //移動可能
                }else if(board_info[I-1][J-1]==9){
                    return 2        //移動先がゴール
                }else{
                    return 0        //移動不可(移動予定先が壁)
                }
            }else{                  //上も左も移動不可
                return 0            //移動不可(移動予定先が壁)
            }
        
        case 8 :                    //左下に移動できるか
        //左下に移動する場合、下または左が移動可能マスでなければならない
            
            if(board_info[I+1][J]==1 || board_info[I][J-1]==1){   //下または左が移動可能
                if(board_info[I+1][J-1]==1){
                    return 1        //移動可能
                }else if(board_info[I+1][J-1]==9){
                    return 2        //移動先がゴール
                }else{
                    return 0        //移動不可(移動予定先が壁)
                }
            }else{                  //下も左も移動不可
                return 0            //移動不可(移動予定先が壁)
            }
        
        case 9 : return 1           //移動しない場合(待機)
        default : break
    }
    return 0
}

func change_board(board_info:inout[[Int]],go:inout Int,x:Int){ //自分のコマを移動させる関数
    var I=0
    var J=0
    for i in 1...x{
        for j in 1...x{
            if(board_info[i][j]==0){
                I=i
                J=j
            }
        }
    }
    board_info[I][J]=Int.random(in:1...2)
    
    switch(go){
    //指定した方向に移動
        case 1 : board_info[I-1][J]=0; break     //上
        case 2 : board_info[I+1][J]=0; break     //下
        case 3 : board_info[I][J+1]=0; break     //右
        case 4 : board_info[I][J-1]=0; break     //左
        case 5 : board_info[I-1][J+1]=0; break   //右上
        case 6 : board_info[I+1][J+1]=0; break   //右下
        case 7 : board_info[I-1][J-1]=0; break   //左上
        case 8 : board_info[I+1][J-1]=0; break   //左下
        case 9 : board_info[I][J]=0; break       //待機(移動しない)
        default : break
    }
    
    //移動後、移動可能マスと移動不可マス(壁)を変更
    for i in 1...x{
        for j in 1...x{
            if(board_info[i][j]==1 || board_info[i][j]==2){
                board_info[i][j]=Int.random(in:1...2)
            }
        }
    }
    go=0
}

func now_board(board_info:[[Int]],x:Int){     //自分の現在地を表示する関数
    var I=0
    var J=0
    for i in 1...x{
        for j in 1...x{
            if(board_info[i][j]==0){
                I=i
                J=j
            }
        }
    }
    print("現在地：上から",I,"左から",J)
}

//ゴールにかかったターン辿り着いた場合の迷路の更新
//自分が元居た場所を移動可能マスにする
func finish_board(board_info:inout[[Int]],x:Int){
    var I=0
    var J=0
    for i in 1...x{
        for j in 1...x{
            if(board_info[i][j]==0){
                I=i
                J=j
            }
        }
    }
    board_info[I][J]=1
}
func main(){
    let x=8     //迷路の幅の大きさ
    var go:Int  //移動先を示す変数
    var ok=0    //移動先が移動可能かを示すフラグ
    var goal=0  //ゴールしたことを示すフラグ
    var n=1     //ターンを示す変数
    
    var board_info:[[Int]]=Array(repeating:Array(repeating:0,count:x+2),count:x+2)   //迷路の情報を格納する2次元配列
    var board=String(repeating:"■", count:x+2)      //迷路の表示の仕方を格納する2次元配列
    
    make_board(board_info:&board_info,x:x)    //迷路の初期生成
    print_board(board_info:board_info,board:&board,x:x)   //迷路の表示
    
    print("⋆:移動可能マス ■:壁(移動不可)　○:現在地　●:ゴール")
    while(goal==0){
        now_board(board_info:board_info,x:x)         //自分の現在地の表示
        print(n,"ターン目")
        print("どこに移動?(上:1 下:2 右:3 左:4 右上:5 右下:6 左上:7 左下:8 停止:9)")
        go=Int(readLine()!)!    //移動先を指定
        while(go<1 || go>9){
            print("\n1～9の範囲で入力してください")
            print("どこに移動?(上:1 下:2 右:3 左:4 右上:5 右下:6 左上:7 左下:8 停止:9)")
            go=Int(readLine()!)!
        }
        
        ok=check_board(go,board_info:board_info,x:x)      //移動予定先が移動可能マスかどうか
        while(ok==0){
            print("\nそこには行けません")
            print("どこに移動?(上:1 下:2 右:3 左:4 右上:5 右下:6 左上:7 左下:8 停止:9)")
            go=Int(readLine()!)!
            while(go<1 || go>9){
                print("\n1～9の範囲で入力してください")
                print("どこに移動?(上:1 下:2 右:3 左:4 右上:5 右下:6 左上:7 左下:8 停止:9)")
                go=Int(readLine()!)!
            }
            ok=check_board(go,board_info:board_info,x:x)
        }
        
        if(ok==1){          //移動先が移動可能
            change_board(board_info:&board_info,go:&go,x:x)   //移動
            print_board(board_info:board_info,board:&board,x:x)
        }else if(ok==2){    //移動先がゴール
            goal=1
            finish_board(board_info:&board_info,x:x)
            print_board(board_info:board_info,board:&board,x:x)
            print("ゴールしました。")
            print("ゴールにかかったターン：",n)
        }
        
        n=n+1   //ターンの更新
        ok=0
    }
}
main()
