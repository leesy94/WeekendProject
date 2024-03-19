<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../include/header.jsp" %>
<div class="con wrap list-wrap">
    <div class="container">
        <h3>지역 선택</h3>
        <%-- 농장 필터 --%>
        <div class="filter">
            <input type="hidden" id="farm_select" name="farm_select">
            <ul class="swiper-wrapper">
                <c:forEach items="${localArray}" var="localArray" varStatus="idx">
                    <li class="swiper-slide <c:if test="${param.local eq localArray}">on</c:if>">
                        <a href="javascript:void(0);">${localArray}</a>
                       <%-- <a href="/list?local=${localArray}">${localArray}</a>--%>
                    </li>
                </c:forEach>
                <li class="selector"></li>
            </ul>
            <div class="filter-button-prev"><i class="fa-solid fa-angle-left"></i></div>
            <div class="filter-button-next"><i class="fa-solid fa-angle-right"></i></div>
        </div>
        <%-- 농장 목록 --%>
        <div class="farm-list">
            <ul>
                <c:choose>
                    <c:when test="${farms ne null}">
                        <c:forEach var="farm" items="${farms}" varStatus="status">
                            <%--<c:forEach items="${farms}" var="farm">--%>
                            <li>
                                <a href="/listDetail?id=${farm.wfIdx}">
                                    <div class="view">
                                        <div class="view-img">
                                            <img src="${farm.wfImgUrl1}">
                                        </div>
                                    </div>
                                    <div class="desc">
                                        <div class="left">
                                            <p class="title">${farm.wfSubject}</p>
                                            <span class="theme">${farm.wfTheme}</span>
                                        </div>
                                        <div class="right">
                                            <i class="fa-solid fa-star"></i>
                                            <span class="score">${farm.wfRating}</span>
                                        </div>
                                    </div>
                                </a>
                            </li>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <li class="empty_li">자료가 없습니다.</li>
                    </c:otherwise>
                </c:choose>
            </ul>
            <div class="pagination">
                <c:set value="${empty param.local ? '전체' : param.local}" var="local"/>
                <!-- 이전페이지 -->
                <c:choose>
                    <c:when test="${pageNumber > 1}">
                        <a href="list?local=${local}&page=1"><i class="fa-solid fa-angles-left"></i></a>
                        <a href="list?local=${local}&page=${nowPage}"><i class="fa-solid fa-angle-left"></i></a>
                    </c:when>
                    <c:otherwise>
                        <a href="javascript:void(0)"><i class="fa-solid fa-angles-left"></i></a>
                        <a href="javascript:void(0)"><i class="fa-solid fa-angle-left"></i></a>
                    </c:otherwise>
                </c:choose>

                <!-- pagination -->
                <c:forEach begin="${startPage}" end="${endPage}" var="i">
                    <a class="<c:if test='${param.page eq null ? i eq 1 : param.page eq i}'>on</c:if>" href="list?local=${local}&page=${i}"><strong>${i}</strong></a>
                </c:forEach>

                <!-- 다음페이지 -->
                <c:choose>
                    <c:when test="${pageNumber < totalPages}">
                        <a href="list?local=${local}&page=${nowPage + 2}"><i class="fa-solid fa-angle-right"></i></a>
                        <a href="list?local=${local}&page=${totalPages}"><i class="fa-solid fa-angles-right"></i></a>
                    </c:when>
                    <c:otherwise>
                        <a href="javascript:void(0)"><i class="fa-solid fa-angle-right"></i></a>
                        <a href="javascript:void(0)"><i class="fa-solid fa-angles-right"></i></a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

    <%--        <div class="map-wrap">--%>
        <%--            <div id="map" class="map"></div>--%>
        <%--        </div>--%>

    </div>
    <%--<div id="content">
        여기는 콘텐츠가 표시될 영역입니다.
    </div>--%>
</div>
<script>
    // /* map영역 */
    // var mapContainer = document.getElementById('map'), // 지도를 표시할 div
    //     mapOption = {
    //         center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
    //         level: 3 // 지도의 확대 레벨
    //     };
    //
    // // 지도를 표시할 div와  지도 옵션으로  지도를 생성
    // var map = new kakao.maps.Map(mapContainer, mapOption);

    /* swiper */
    var swiper = new Swiper(".filter", {
        slidesPerView: 9,
        spaceBetween: 0,
        navigation: {
            nextEl: ".filter-button-next",
            prevEl: ".filter-button-prev",
        },
    });
    if($(".swiper-slide").hasClass("on") === true) {
        let target = $(".swiper-slide.on");
        muCenter(target);
        $(".selector").css("left",(target.position().left) + 20);
        console.log("left"+target.position().left);
    }else {
        $(".swiper-slide").eq(0).addClass("on");
    }
    /*var $snbSwiperItem = $('.filter .swiper-wrapper .swiper-slide a');
    $snbSwiperItem.click(function(){
        var target = $(this).parent();
        $snbSwiperItem.parent().removeClass('on')
        target.addClass('on');
        muCenter(target);
    });*/

    /***리로딩 되는 현상****/
    // document.addEventListener("DOMContentLoaded", function () {
    //     let tabs = document.querySelectorAll(".filter ul li a");
    //     let selector = document.querySelector(".selector");
    //
    //     if (tabs.length > 0) {
    //         filter({currentTarget: tabs[0]});
    //     }
    //
    //     for (let i = 0; i < tabs.length; i++) {
    //         tabs[i].addEventListener("click", filter);
    //     }
    //
    //     function filter(event) {
    //         let label = event.currentTarget;
    //         let selectorHeight = selector.offsetHeight;
    //
    //         tabs.forEach(tab => tab.classList.remove("on"));
    //         label.classList.add("on");
    //
    //         // window.location.href="/list?local=" + label.textContent;
    //
    //         selector.style.left = label.offsetLeft + 50 + "px";
    //         selector.style.width = label.offsetWidth + "px";
    //         selector.style.top = (label.offsetTop + label.offsetHeight - selectorHeight / 2) + "px";
    //     }
    // });

    // document.addEventListener("DOMContentLoaded", function () {
    //     let tabs = document.querySelectorAll(".filter ul li a");
    //     let selector = document.querySelector(".selector");
    //     let currentTab = new URLSearchParams(window.location.search).get('tab');
    //
    //     tabs.forEach(function(tab, index) {
    //         if (tabs.length > 0 && (!currentTab && index === 0) || (tab.textContent === currentTab)) {
    //             filter({currentTarget: tab});
    //         }
    //
    //         tab.addEventListener("click", function(e) {
    //             e.preventDefault();
    //             window.location.href = "/list?local=" + tab.textContent + "&tab=" + tab.textContent;
    //         });
    //     });
    //
    //     function filter(event) {
    //         let label = event.currentTarget;
    //
    //         tabs.forEach(tab => tab.classList.remove("on"));
    //         label.classList.add("on");
    //
    //         selector.style.left = label.offsetLeft + 50 + "px";
    //         selector.style.width = label.offsetWidth + "px";
    //         selector.style.top = (label.offsetTop + label.offsetHeight - selector.offsetHeight / 2) - 2 + "px";
    //     }
    // });

    // document.addEventListener("DOMContentLoaded", function () {
    //     let tabs = document.querySelectorAll(".filter ul li a");
    //     let selector = document.querySelector(".selector");
    //     let currentTab = localStorage.getItem('currentTab');
    //
    //     tabs.forEach(function(tab) {
    //         if ((currentTab && tab.textContent === currentTab) || (!currentTab && tab === tabs[0])) {
    //             filter({currentTarget: tab});
    //         }
    //
    //         tab.addEventListener("click", function(e) {
    //             e.preventDefault();
    //             localStorage.setItem('currentTab', tab.textContent);
    //             window.location.href = "/list?local=" + tab.textContent;
    //         });
    //     });
    //
    //     function filter(event) {
    //         let label = event.currentTarget;
    //
    //         tabs.forEach(tab => tab.classList.remove("on"));
    //         label.classList.add("on");
    //
    //         selector.style.left = label.offsetLeft + 50 + "px";
    //         selector.style.width = label.offsetWidth + "px";
    //         selector.style.top = (label.offsetTop + label.offsetHeight - selector.offsetHeight / 2) - 2 + "px";
    //     }
    // });

    // document.addEventListener("DOMContentLoaded", function () {
    //     let tabs = document.querySelectorAll(".filter ul li a");
    //     let selector = document.querySelector(".selector");
    //
    //     // URL에서 현재 탭 정보를 가져오기
    //     let currentTab = new URL(window.location).searchParams.get("local");
    //
    //     tabs.forEach(function(tab) {
    //         // 페이지 로드 시 현재 탭에 따라 filter 위치 설정
    //         if (tab.getAttribute("href").includes(currentTab)) {
    //             updateVisualCues(tab);
    //         }
    //
    //         tab.addEventListener("click", function(e) {
    //             e.preventDefault();
    //
    //             let url = this.getAttribute("href");
    //             let local = url.split("?local=")[1]; // href에서 local 값을 추출
    //
    //             // History API를 사용하여 URL 변경
    //             window.history.pushState({ path: url }, '', url);
    //
    //             // 시각적 강조와 선택 표시기 위치 조정 로직을 실행
    //             updateVisualCues(this);
    //         });
    //     });
    //
    //     function updateVisualCues(tab) {
    //         tabs.forEach(t => t.classList.remove("on"));
    //         tab.classList.add("on");
    //
    //         let selectorHeight = selector.offsetHeight;
    //         selector.style.left = tab.offsetLeft + "px";
    //         selector.style.width = tab.offsetWidth + "px";
    //         selector.style.top = (tab.offsetTop + tab.offsetHeight - selectorHeight / 2) + "px";
    //     }
    //
    //     // popstate 이벤트 리스너를 추가하여 브라우저의 뒤로 가기/앞으로 가기 버튼 사용 시 탭 상태를 업데이트
    //     window.addEventListener("popstate", function(e) {
    //         // URL을 기반으로 탭 상태를 업데이트하는 로직을 여기에 추가
    //         let currentTab = new URL(window.location).searchParams.get("local");
    //         tabs.forEach(function(tab) {
    //             if (tab.getAttribute("href").includes(currentTab)) {
    //                 updateVisualCues(tab);
    //             }
    //         });
    //     });
    // });

    // document.addEventListener("DOMContentLoaded", function () {
    //     let tabs = document.querySelectorAll(".filter ul li a");
    //     let selector = document.querySelector(".selector");
    //
    //     // URL에서 현재 선택된 탭 정보를 추출
    //     const queryParams = new URLSearchParams(window.location.search);
    //     const activeTabParam = queryParams.get('tab');
    //
    //     // 현재 선택된 탭을 활성화
    //     if (activeTabParam) {
    //         const activeTab = Array.from(tabs).find(tab => tab.textContent === activeTabParam);
    //         if (activeTab) {
    //             filter({ currentTarget: activeTab });
    //         }
    //     } else if (tabs.length > 0) {
    //         // URL에 탭 정보가 없으면 첫 번째 탭을 활성화
    //         filter({ currentTarget: tabs[0] });
    //     }
    //
    //     tabs.forEach(function(tab) {
    //         tab.addEventListener("click", function(event) {
    //             filter(event);
    //
    //             // URL 업데이트
    //             const tabText = event.currentTarget.textContent;
    //             const newUrl = new URL(window.location);
    //             newUrl.searchParams.set('tab', tabText);
    //             window.history.pushState({}, '', newUrl);
    //         });
    //     });
    //
    //     function filter(event) {
    //         event.preventDefault();
    //         let label = event.currentTarget;
    //
    //         tabs.forEach(tab => tab.classList.remove("on"));
    //         label.classList.add("on");
    //
    //         // 선택 표시기 위치 조정
    //         selector.style.left = label.offsetLeft + 50 + "px";
    //         selector.style.width = label.offsetWidth + "px";
    //         selector.style.top = (label.offsetTop + label.offsetHeight - selector.offsetHeight / 2) + "px";
    //     }
    // });














    /*** 아작스로 ****/
    // document.addEventListener("DOMContentLoaded", function () {
    //     let tabs = document.querySelectorAll(".filter ul li a");
    //     // let contentDiv = document.getElementById("content"); // 컨텐츠를 업데이트할 요소
    //     let selector = document.querySelector(".selector");
    //
    //     tabs.forEach(function(tab) {
    //         tab.addEventListener("click", function(e) {
    //             e.preventDefault(); // 기본 동작 방지
    //
    //             let url = this.getAttribute("href"); // 탭에 설정된 URL을 가져옵니다.
    //
    //             // AJAX 요청을 생성하고 실행합니다.
    //             fetch(url)
    //                 .then(response => response.text())
    //                 .then(html => {
    //                     // contentDiv.innerHTML = html; // 응답으로 받은 HTML로 컨텐츠 업데이트
    //                     tabs.getAttribute('href').innerText(url);
    //                     console.log(url);
    //                 })
    //                 .catch(error => {
    //                     console.error('Error loading the content: ', error);
    //                 });
    //
    //                 if (tabs.length > 0) {
    //                     filter({currentTarget: tabs[0]});
    //                 }
    //
    //                 for (let i = 0; i < tabs.length; i++) {
    //                     tabs[i].addEventListener("click", filter);
    //                 }
    //
    //                 function filter(event) {
    //                     let label = event.currentTarget;
    //                     let selectorHeight = selector.offsetHeight;
    //
    //                     tabs.forEach(tab => tab.classList.remove("on"));
    //                     label.classList.add("on");
    //
    //                     // window.location.href="/list?local=" + label.textContent;
    //
    //                     selector.style.left = label.offsetLeft + 50 + "px";
    //                     selector.style.width = label.offsetWidth + "px";
    //                     selector.style.top = (label.offsetTop + label.offsetHeight - selectorHeight / 2) + "px";
    //                 }
    //         });
    //     });
    // });

    // document.addEventListener("DOMContentLoaded", function () {
    //     let tabs = document.querySelectorAll(".filter ul li a");
    //     let selector = document.querySelector(".selector");
    //     // 컨텐츠를 업데이트할 요소의 주석을 해제하고 올바르게 사용하도록 합니다.
    //     // let contentDiv = document.getElementById("content");
    //
    //     tabs.forEach(function(tab) {
    //         tab.addEventListener("click", function(e) {
    //             // e.preventDefault(); // 기본 동작 방지
    //             console.log(tab);
    //
    //             let url = this.getAttribute("href"); // 탭에 설정된 URL을 가져옵니다.
    //
    //             // AJAX 요청을 생성하고 실행합니다.
    //             fetch(url)
    //                 .then(response => response.text())
    //                 .catch(error => {
    //                     console.error('Error loading the content: ', error);
    //                 });
    //
    //             // 시각적 강조와 선택 표시기 위치 조정 로직을 재사용합니다.
    //             updateVisualCues(this);
    //         });
    //     });
    //
    //     function updateVisualCues(tab) {
    //         tabs.forEach(t => t.classList.remove("on"));
    //         tab.classList.add("on");
    //         let selectorHeight = selector.offsetHeight;
    //         selector.style.left = tab.offsetLeft + 50 +"px";
    //         selector.style.width = tab.offsetWidth + "px";
    //         selector.style.top = (tab.offsetTop + tab.offsetHeight - selectorHeight / 2) + "px";
    //     }
    // });

    // document.addEventListener("DOMContentLoaded", function () {
    //     let tabs = document.querySelectorAll(".filter ul li a");
    //     let selector = document.querySelector(".selector");
    //
    //     // 초기 선택되어야 하는 탭을 정의 (예: 첫 번째 탭)
    //     if (tabs.length > 0) {
    //         updateVisualCues(tabs[0]); // 첫 번째 탭에 대해 시각적 강조와 위치 조정을 적용
    //         tabs[0].classList.add("on"); // 첫 번째 탭에 "on" 클래스를 추가
    //     }
    //
    //     tabs.forEach(function(tab) {
    //         tab.addEventListener("click", function(e) {
    //             e.preventDefault(); // 기본 동작 방지
    //             updateVisualCues(this); // 클릭된 탭에 대해 시각적 강조와 위치 조정을 적용
    //         });
    //     });
    //
    //     function updateVisualCues(tab) {
    //         tabs.forEach(t => t.classList.remove("on")); // 모든 탭에서 "on" 클래스 제거
    //         tab.classList.add("on"); // 현재 탭에 "on" 클래스 추가
    //         // 선택 표시기의 위치와 크기를 조정
    //         selector.style.left = tab.offsetLeft + 50 + "px";
    //         selector.style.width = tab.offsetWidth + "px";
    //         selector.style.height = tab.offsetHeight + "px";
    //         selector.style.top = (tab.offsetTop + tab.offsetHeight - selector.offsetHeight / 2) + "px";
    //     }
    // });



    // document.addEventListener("DOMContentLoaded", function () {
    //     let tabs = document.querySelectorAll(".filter ul li a");
    //     let selector = document.querySelector(".selector");
    //
    //     // 첫 번째 탭을 기본값으로 설정
    //     if (tabs.length > 0) {
    //         filter({ currentTarget: tabs[0] });
    //     }
    //
    //     tabs.forEach(function(tab) {
    //         tab.addEventListener("click", function(e) {
    //             e.preventDefault(); // 기본 동작 방지
    //             filter(e); // 필터링 로직을 호출하여 시각적 강조 및 선택 표시기 위치 조정
    //
    //             // AJAX 요청 로직은 여기에 적합하지 않거나, 페이지를 이동시키지 않고 다른 방식으로 처리해야 합니다.
    //             // 예를 들어, AJAX 요청 결과를 페이지의 다른 부분에 반영하는 로직으로 대체
    //         });
    //     });
    //
    //     function filter(event) {
    //         let label = event.currentTarget;
    //         tabs.forEach(tab => tab.classList.remove("on"));
    //         label.classList.add("on");
    //
    //         // 선택 표시기의 위치와 크기를 조정
    //         let selectorHeight = selector.offsetHeight;
    //         selector.style.left = label.offsetLeft + 50 + "px";
    //         selector.style.width = label.offsetWidth + "px";
    //         selector.style.top = (label.offsetTop + label.offsetHeight - selectorHeight / 2) + "px";
    //     }
    // });

    /***셋타임아웃사용***/
    document.addEventListener("DOMContentLoaded", function () {
        let tabs = document.querySelectorAll(".filter ul li a");
        let selector = document.querySelector(".selector");

        /*if (tabs.length > 0) {
            tabs.forEach(tab => tab.classList.remove("on"));
            tabs[0].classList.add("on");
            filter({currentTarget: tabs[0]});
        }*/
        tabs.forEach(tab => {
            tab.addEventListener("click", filter);
        });

        function filter(event) {

            // 클릭 이벤트가 발생한 경우, "on" 클래스를 관리합니다.
            tabs.forEach(tab => tab.closest("li").classList.remove("on"));
            let label = event.currentTarget;
            label.closest("li").classList.add("on");

            // 선택 표시기의 위치와 크기를 조정합니다.
            let selectorHeight = selector.offsetHeight;
            selector.style.left = label.offsetLeft + "px";
            selector.style.width = label.offsetWidth + "px";
            /*selector.style.top = (label.offsetTop + label.offsetHeight - selectorHeight / 2) + "px";*/

            setTimeout(function(){
                if(label.innerText !== "전체") {
                    window.location.href="/list?local="+label.innerText;
                }
            },200);
            console.log(label.innerText);
            console.log(label.offsetLeft , selector.offsetLeft);
            if(label.innerText !== "전체" && label.offsetLeft === selector.left) {
                window.location.href="/list?local="+label.innerText;
            }

        }
    });

    function muCenter(target){
        var snbwrap = $('.filter .swiper-wrapper');
        var targetPos = target.position();
        var box = $('.filter');
        var boxHarf = box.width()/2;
        var pos;
        var listWidth=0;

        snbwrap.find('.swiper-slide').each(function(){ listWidth += $(this).outerWidth(); })

        var selectTargetPos = targetPos.left + target.outerWidth()/2;
        if (selectTargetPos <= boxHarf) { // left
            pos = 0;
        }else if ((listWidth - selectTargetPos) <= boxHarf) {     //right
            pos = listWidth-box.width();
        }else {
            pos = selectTargetPos - boxHarf;
        }

        setTimeout(function(){snbwrap.css({
            "transform": "translate3d("+ (pos*-1) +"px, 0, 0)",
            "transition-duration": "500ms"
        })}, 200);
    }

</script>

<%@include file="../include/footer.jsp" %>
