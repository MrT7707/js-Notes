# 安装
* npm i react-beautiful-dnd 或 yarn add react-beautiful-dnd

# react-beautiful-dnd结构
* DragDropContext - 构建一个可以拖拽的范围。

onDragStart

onDragUpdate

onDragEnd

* Droppable - 构建一个可以被拖拽放入的区域块。
* Draggalbe - 可被拖拽的元素。

# 使用

## 引入react-beautiful-dnd
把你想能够拖放的react代码放到DragDropContext中（建议包裹整个应用）

DragDropContext不支持嵌套

且必须设置DranDropContext的onDragEnd钩子函数(拖拽后的数组重新排序操作在这里进行)

```javascript
import { DragDropContext } from 'react-beautiful-dnd';

class App extends React.Component {
  onDragStart = () => {
    /*...*/
  };
  onDragUpdate = () => {
    /*...*/
  }
  onDragEnd = () => {
    // the only one that is required
  };

  render() {
    return (
      <DragDropContext
        onDragStart={this.onDragStart}
        onDragUpdate={this.onDragUpdate}
        onDragEnd={this.onDragEnd}
      >
        <div>Hello world</div>
      </DragDropContext>
    );
  }
}
```

## Dragppable配置

```javascript
import { Droppable } from 'react-beautiful-dnd';

<Droppable droppableId="droppable-1">
  {(provided, snapshot) => (
    <div
      ref={provided.innerRef}
      style={{ backgroundColor: snapshot.isDraggingOver ? 'blue' : 'grey' }}
      {...provided.droppableProps}
    >
      <h2>I am a droppable!</h2>
      {provided.placeholder}
    </div>
  )}
</Droppable>;
```
* 必需的DroppableId（字符串），用于唯一标识应用程序的droppable。不要更改此ID - 特别是在拖动时。
* direction:

vertical：水平拖拽

horizontal：垂直拖拽

* Droppable的React子元素必须是返回ReactElement的函数。
```javascript
<Droppable droppableId="droppable-1">
 {(provided, snapshot) => ({
   /*...*/
 })}
</Droppable>;
```
该函数提供了两个参数:provided 和 snapshot

1. provided.innerRef: 为了使droppable正常工作，必须将provided.innerRef绑定到ReactElement中最高可能的DOM节点。
2. provided.droppableProps: 这是一个Object，它包含需要应用于Droppable元素的属性,包含一个数据属性，可以用它来控制一些不可见的CSS
3. provided.placeholder: 占位符
4. snapshot： 当前拖动状态，可以用来在被拖动时改变Droppable的外观。

```javascript
<Droppable droppableId="droppable-1">
{(provided, snapshot) => (
<div
ref={provided.innerRef}
style={{ backgroundColor: snapshot.isDraggingOver ? 'blue' : 'grey' }}
{...provided.droppableProps}
>
I am a droppable!
</div>
)}
</Droppable>;
```

## Draggable
```javascript
import { Draggable } from 'react-beautiful-dnd';

<Draggable draggableId="draggable-1" index={0}>
  {(provided, snapshot) => (
    <div
      ref={provided.innerRef}
      {...provided.draggableProps}
      {...provided.dragHandleProps}
    >
      <h4>My draggable</h4>
    </div>
  )}
</Draggable>;
```
1. Draggable必须始终包含在Droppable中。
2. 可以在Droppable内重新排序Draggable或移动到另一个Droppable。
3. DraggablebId（字符串）：必须存在唯一ID，和index（如果为遍历 key也需要）不要更改此ID - 特别是在拖动时。
4. isDragDisabled： 默认false，一个可选标志，用于控制是否允许Draggable拖动。
5. provided.draggableProps 和 provided.dragHandleProps 必须套用至元件
6. 其他同Droppable，详情见[官方文档](https://github.com/atlassian/react-beautiful-dnd)

## 数组重新排序
```javascript
onDragEnd = result => {
  const { source, destination, draggableId } = result;
  if (!destination) {
    return;
  }

  let arr = Array.from(this.state.todos);
  const [remove] = arr.splice(source.index, 1);
  arr.splice(destination.index, 0, remove);
  this.setState({
    todos: arr,
  });
}
```