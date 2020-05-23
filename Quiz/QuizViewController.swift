//
//  QuizViewController.swift
//  Quiz
//
//  Created by 齊藤愛華 on 2020/05/23.
//  Copyright © 2020 com.lifeistech. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    //問題文を格納する配列
    var quizuArray = [Any]()
    
    //正解数
    var correctAnswer : Int = 0
    
    //クイズを表示するtextview
    @IBOutlet var quizTextView: UITextView!
    
    //選択肢のボタン
    @IBOutlet var choiceBotton1: UIButton!
    @IBOutlet var choiceBotton2: UIButton!
    @IBOutlet var choiceBotton3: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //一時的にクイズを格納しておく配列
        var tmpArray = [Any]()
        
        //tmpArrayに問題文、3つの選択肢、答えの番号が入った配列を追加していく
        tmpArray.append(["『モナ・リザ』が収蔵されている美術館はどこ？","メトロポリタン美術館","ルーブル美術館","ポーラ美術館",2])
        tmpArray.append(["「大きな家」という意味がある、古代エジプト王の称号は何？","ファラオ","ミイラ","ツタンカーメン",1])
        tmpArray.append(["国会で通常水が用意されるが、参議院農林水産委員会のみ用意される飲み物は？","牛乳","抹茶","ウイスキー",1])
        tmpArray.append(["大根の栄養価が高い部分は？","葉","上部","下部",1])
        tmpArray.append(["わたあめを発祥した国は？","ドイツ","中国","アメリカ",3])
        tmpArray.append(["いちごは何科のしょくぶつ？","バラ科","いちご科","ウリ科",1])
        tmpArray.append(["眠気を抑えたい時、どこのツボを押さえると良い？","ふくらはぎ","手の指先","鎖骨",2])
        tmpArray.append(["蝶の正しい数え方は？","羽","頭","足",2])
        tmpArray.append(["塗り薬や化粧水が肌に染み込み始める時間の目安は？","20分から","30分から","40分から",1])
        tmpArray.append(["際限がないこと、『何天井』？","赤","黄","青",3])
       
        
        //問題をシャッフルしてquizArrayに格納する
        while (tmpArray.count > 0) {
            let index = Int(arc4random()) % tmpArray.count
            quizuArray.append(tmpArray[index])
            tmpArray.remove(at: index)
        }
        
        choiceQuiz()

        // Do any additional setup after loading the view.
    }
    
    func choiceQuiz() {
        //一時的にクイズを取り出す配列
        let tmpArray = quizuArray[0] as! [Any]
        
        //問題文のテキスト表示
        quizTextView.text = tmpArray[0] as! String
        
        //選択肢以外のボタンにそれぞれの選択肢のテキストをセット
        choiceBotton1.setTitle(tmpArray[1] as? String, for: .normal)
        choiceBotton2.setTitle(tmpArray[2] as? String, for: .normal)
        choiceBotton3.setTitle(tmpArray[3] as? String, for: .normal)
    }
    
    @IBAction func choiceAnswer(sender: UIButton) {
        
        let tmpArray = quizuArray[0] as! [Any]
        if tmpArray[4] as! Int == sender.tag {
            
            //正解数増やす
            correctAnswer = correctAnswer + 1
        }
        
        //解いた問題をquizArrayから取り除く
        quizuArray.remove(at: 0)
        
        //解いた問題数の合計があらかじめ設定していた問題数に達したら結果画面へ
        if quizuArray.count == 0 {
            performSegueToResult()
        } else {
            choiceQuiz()
        }
        
    }
    
    func performSegueToResult() {
        performSegue(withIdentifier: "toResultView", sender: nil)
    }
    
    //segueを準備するときに呼ばれるメゾッド
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResultView" {
            let resultViewController = segue.destination as! ResultViewController
            resultViewController.correctAnswer = self.correctAnswer
            }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
