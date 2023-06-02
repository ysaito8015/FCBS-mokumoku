# 導入と例
## 1.1 導入
- 確率の文章的説明
- 確率と情報との間には関係がある
- ベイズルールは新たな情報によって信念を更新する合理的な手法
- ベイズルールによる機能的な学習の過程はベイズ推測と呼ばれる
    - Bayesian inference
- ベイズ法 Bayesian methods とは、ベイズ推測の原理から導出されたデータ分析のツール


### ベイズ学習
- 統計的帰納とはある集団の一般的な特性について、その集団の一部の構成員を用いて学習す過程のこと
- 集団の特性 $\theta$
- 集団から抽出されたデータ $y$
- 標本空間 sample space $\mathcal{y}$, $y \in \mathcal{y}$
- パタメータ空間 parameter space $\Theta$,  $\theta \in \Theta$
- ベイズルール Bayes' rule
$$
p(\theta|y)=\frac{p(y|\theta)p(\theta)}{\int_{\Theta}p(y|~{\theta})p(~{\theta})d ~{\theta}}
$$

## 1.2 なぜベイズか
- ベイズ推測が有用な例示


### 1.2.1 まれな事象の確率の推定

#### パラメータ空間と標本空間
- ある街のある感染症の有病率
- 無作為標本 (20 人)
- 感染したヒトの割合 $\theta$

$$
\Theta = [0,1], \mathcal{y} = {0,1, \ldots ,20}
$$

#### 標本モデル
- 標本のうち何人が感染しているか $Y$

$$
Y|\theta ~ \mathrm{binominal}(20,\theta)
$$
