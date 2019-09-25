# Criando dados básicos para Color (Cores)
Color.new(name:'Preto'          ,code:'#000000').save
Color.new(name:'Branco'         ,code:'#ffffff').save
Color.new(name:'Cinza Claro'    ,code:'#f0f0f0').save
Color.new(name:'Cinza Escuro'   ,code:'#363636').save
Color.new(name:'Azul claro'     ,code:'#4de2f9').save
Color.new(name:'Azul Escuro'    ,code:'#2f3b93').save
Color.new(name:'Vermelho Claro' ,code:'#f24848').save
Color.new(name:'Vermelho Escuro',code:'#af1a1a').save
Color.new(name:'Verde Claro'    ,code:'#8cea64').save
Color.new(name:'Verde Escuro'   ,code:'#418c21').save

# Criando dados básicos para Size (Tamanho):
Size.new(name:'P' ,description:'Tamanho P - Pequeno')      .save
Size.new(name:'M' ,description:'Tamanho M - Médio')        .save
Size.new(name:'G' ,description:'Tamanho G - Grande')       .save
Size.new(name:'XG',description:'Tamanho XG - Extra Grande').save
