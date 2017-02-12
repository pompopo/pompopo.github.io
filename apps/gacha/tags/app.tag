<app>
  <h1>ガチャガチャくん</h1>
  <input type="text" value="1" onKeyup={this.onChangeP}>%</input>
  <input type="text" value="10" onKeyup={this.onChangeSample}>回</input>

  <p>ひける確率={this.chance}%</p>
  <p>95%ひける回数: {this.expectation}回</p>
  <table>
    <tr each={history in this.table}>
      <td>{history[0]}回</td>
      <td>{history[1]}%</td>
    </tr>
  </table>
  <script>
    this.p = 1
    this.sample = 10

    this.on('mount', () => {
      this.calc()
    })

    onChangeP(e) {
      this.p = parseFloat(e.target.value)
      this.calc()
    }

    onChangeSample(e) {
      this.sample = parseInt(e.target.value)
      this.calc()
    }

    calc() {
      if (this.p <= 0 || this.p > 100 || this.sample < 1) {
        return
      }

      const p = this.p * 0.01
      let chance = 1
      let table = []
      for (let i = 0; i < this.sample; i++) {
        chance = chance * (1 - p)
        if (i % 5 === 4) {
          table.push([i + 1, (1 - chance) * 100])
        }
      }
      this.chance = (1 - chance) * 100
      this.table = table
      this.expectation = Math.ceil(Math.log(0.05) / Math.log(1 - p))
      this.update()
    }
  </script>
</app>
