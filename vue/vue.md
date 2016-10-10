

# 数据初始化

明确定义的数据模型， 更加合适 Vue 的数据观察模式。
建议在定义组件时，在data选项中初始化所有需要进行动态观察的属性。

Vue 是通过递归遍历初始化中的所有属性，并用 Object.defineProperty(); 把它们转化为 getter 和 setter 来实习那数据观察的
如果一个属性在实例创建史不存在于初始化数据中，那么Vue 就没有办法观看这个属性。


# 添加和删除属性

ECMAScript 5 中，当一个新的属性被添加到对象或者从对象中删除的时候，并没有办法可以检测变化。
Vue 为了解决这个方法为  被观察的对象添加三个扩展方法：
* obj.$add(key, value);
* obj.$set(key, value);
* obj.$delete(key);

通过调用这些方法给观察对象中添加或删除属性，就能够触发对应的DOM更新。

`$add` 与 `$set` 的区别是：
假如当前对象已经含有所使用的key， $add会直接返回。 
当使用$obj.$add(key) 的时候不会将已经存在的值覆盖为的 undefined。 

当通过索引数组赋值来改动数组时，Vue是无法侦测到这类操作。
可以使用扩展方法来确保Vue收到了通知。 Vue观察的数组有两个扩展方法：
* arr.$set(index, value);
* arr.$remove(index | value);


VM实例化对象 也是有方法：
* vm.$get(path);
* vm.$set(path, value);
* vm.$add(key, value);
* vm.$delete(key, value);

vm.$get() vm.set(); 都接受路径

> 必要的时候才动态添加可观察属性。为了理解组件状态，将 `data` 选项看作一个 `schema`。


# 理解异步更新

默认情况下，Vue 的 DOM更新是`异步执行`的。当侦测到数据变化时，Vue会打开一个队列，然后把在同一个事件循环(event loop) 当中观察到数据变化的watcher推送到这队列，假如一个 watcher在一个时间循环中被触发多次了，它只会被推送到队列中一次。然后，在进入下一次的时间循环时，Vue会清空队列并进行必要的DOM更新。在内部，Vue会使用 MutationObserver 来实现队列的异步处理，如果不支持则会回退到 setTimeout(fn, 0);

例如：
当设置 vm.someData = 'new value', DOM并不会马上更新，而是在异步队列被清除，也就是下一个时间循环开始时执行更新。如果想要根据更新的DOM状态去做某些事情，就必要留意。

尽管Vue 鼓励使用 “数据驱动”的方式，避免直接操作DOM，但有时候可能就是想要使用某个熟悉的 jQuery插件。 
数据改变下，调用Vue.nextTick(); 执行时机：DOM更新后的状态。


```html
<div id="app">{{msg}}</div>

<script type="text/javascript">
	var vm = new Vue({
		el: '#app',
		data: {
			msg: 123
		}
	});

	vm.msg = 'new msg';
	
	console.log( vm.$el.textContent ==== 'new msg'; );  // false

	Vue.nextTick(function () {

		console.log( vm.$el.textContent === 'new msg' ); // true;

	});
</script>

```


# 组件作用域


每个Vue组件都是一个拥有自己的独立作用域的 Vue 实例。

> 在父模板中出现的，将在父模板作用域内编译，在子模板中出现的，将在子模板的作用域内编译。

错误：在父模板中尝试将一个指令绑定到子作用域里的属性或者方法上


# 在多个实例之间通讯

Vue中进行父子通讯的方法是，通过`props`传递一个父方法作为一个回调到子组件中。这样使用时的回调传递可以被定义在父模板中，

当需要跨越多层嵌套的组件进行通讯时，可以使用事件系统。


# 片段实例

通过 `replace` 设置为true， 表示：
组件的模板长什么样，渲染出来的DOM就是什么样。

实例将变成一个片段实例，也即没有根元素的实例。它的`$el`指向一个锚节点。
父模板组件元素上的指令，过渡效果和属性绑定(props除外)将无效，因为生成的实例并没有根元素供它们绑定。

大部分情况下，给组件模板一个根元素推荐做法。



new Vue(options);

* el
* data
* methods
* components

* computed

* wtach
* replace

* init
* created
* beforeCompile
* compiled
* ready
* attached
* detached
* beforeDestroy
* destoryed

* events
* mixins: [mixin]


Vue.extend(options);

* template
* data
* props
* compontents
* name


Vue.component(id, options);

* props (array | object)
* templalte
* methods
* data


Vue组件 prop， 事件，slot

prop 允许外部环境传递数据给组件
事件 允许组件触发外部环境的action
slot 允许外部环境插入内容到组件的视图结构内

