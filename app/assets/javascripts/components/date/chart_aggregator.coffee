
colors = [
  "a02030",
  "c03040",
  "e04040",
  "f06040",
  "ff9040",
  "e04020",
  "f06020",
  "ffb050",
  "ffa030",
  "ffc030",
  "ffe040",
  "ffff90",
  "508060",
  "60a050",
  "70b040",
  "a0d060",
  "c0e070",
  "e0f080",
  "40a070",
  "20c080",
  "70d080",
  "a0e0a0",
  "40e0a0",
  "80f0d0",
  "3060b0",
  "3080c0",
  "4090d0",
  "70b0f0",
  "a0e0ff",
  "403090",
  "5040c0",
  "5050e0",
  "6080f0",
  "6020c0",
  "9020f0",
  "a050f0",
  "b080f0",
  "c03070",
  "e040a0",
  "f070d0",
  "f090f0",
  "905060",
  "c07080",
  "f08080",
  "ffa090",
  "ffc0b0",
  "f09080",
  "ffb090",
  "ffd0b0",
  "605050",
  "907060",
  "a08070",
  "b0a080",
  "d0c0a0",
  "e0e0c0",
  "202030",
  "303040",
  "505060",
  "707080",
  "9090a0",
  "a0b0c0",
  "c0d0e0",
  "e0f0f0",
  "ffffff",
  ]


class ChartAggregator
  constructor: (dataset) ->
    @dataset = dataset

  datasets: (activities) =>
    colorInd = 0
    datasets = []
    dataset = @dataset
    
    if dataset == 'Total'
      datasets.push
        label: @datasetLabel()
        backgroundColor: "##{colors[colorInd+1]}"
        borderColor: "##{colors[colorInd]}"
        data: @data(activities)
    else if dataset == 'goal'
      goalReduction = (cur, value, all) =>
        cur[value.goal_id] = (cur[value.goal_id] || []).concat value
        return cur
      byGoal = activities.reduce(goalReduction, {})
      datasets = Object.entries(byGoal).map ([key, value]) =>
        key = 'n/a' if key == 'null'
        colorInd += 1
        label: "#{@datasetLabel()} Goal #{key || 'n/a'}"
        backgroundColor: "##{colors[colorInd+1]}"
        borderColor: "##{colors[colorInd]}"
        data: @data(value)
    else if dataset == 'activity'
      activityReduction = (cur, value, all) => 
        cur[value.description] = (cur[value.description] || []).concat value
        return cur
      byActivity = activities.reduce(activityReduction, {})
      datasets = Object.entries(byActivity).map ([key, value]) =>
        key = 'n/a' if key == 'null'
        colorInd += 1
        label: "#{@datasetLabel()} #{key}"
        backgroundColor: "##{colors[colorInd+1]}"
        borderColor: "##{colors[colorInd]}"
        data: @data(value)

    datasets.filter (set) -> 
      !!set.data.find((num) -> num > 0)

@ChartAggregator = ChartAggregator