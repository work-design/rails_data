import { Line } from '@antv/g2plot'

const chart = document.getElementById('chart')
const url = new URL(location)
url.pathname = url.pathname.replace(/\/chart$/, '')
url.searchParams.set('columns', chart.dataset.columns)
fetch(url, {
  headers: {
    'Content-Type': 'application/json'
  }
}).then((res) => res.json()).then((data) => {
  const linePlot = new Line('chart', {
    data,
    xField: '创建时间',
    yField: '邀请人'
  })
  linePlot.render()
})

