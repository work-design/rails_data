import { Line } from '@antv/g2plot'

const linePlot = new Line('chart', {
  data,
  xField: 'year',
  yField: 'value'
})
linePlot.render()
