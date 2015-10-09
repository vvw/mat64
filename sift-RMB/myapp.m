%function:
%       ����sift������������ʶ��
%ע�⣺
%      ����matlabû���Դ�sift������ȡ��sift������ȡ�����˸��㷨�����ṩ�ĵײ���á�
%      matlab�°��Ѽ���surf������ȡ��surf�����ǻ���sift�Ľ��ģ�������ٶȣ������˸о����������½����������п��ܸ������ԣ�
%referrence��
%      David G. Lowe��Distinctive Image Features from Scale-Invariant Keypoints
%date:2015-1-13
%author:chenyanan
%ת����ע��������http://blog.csdn.net/u010278305

%��ձ�������ȡͼ��
clear;close all
fprintf('/******************************\n**It''s writed by chenyn2014.\n******************************/\n');

%��ȡobject1��ģ��1��
object1= imread('images/object1.jpg');
object1=rgb2gray(object1);

%��ȡobject100��ģ��2��
object100= imread('images/object100.jpg');
object100=rgb2gray(object100);

%��ȡ����(��������и�������ͼƬ���в���)
scene= imread('images/scene100.jpg');
scene=rgb2gray(scene);

%�����е�ģ�����һ��Ԫ��������
object_cell={object1,object100};

%������ģ����ƥ�䣨ģ�������
for i=1:2
    fprintf('\nobjec[ %d]\n\n',i);
    %��ȡ��i��ģ��
    imwrite(object_cell{i},'tmp_images/obj_tmp.jpg');
    match_last=1;
    %��С�������ų���ͼ���ҵ�ƥ�����Ƚ��ʺϵ����ż������ű�����
    for scale=0.1:0.1:0.5
        fprintf('\nscale[ %f]\n\n',scale);
        scene_tmp = imresize(scene, scale);
        imwrite(scene_tmp,'tmp_images/sce_tmp.jpg');
        %ƥ��
        [match_now,keypoint1,keypoint2]=match('tmp_images/sce_tmp.jpg','tmp_images/obj_tmp.jpg');
        %���û���ҵ��ؼ��㣬�������󳡾�ͼ��
        if(match_now==0)
            match_now=1;
            continue;
        end
        %����������󳡾�ͼ��󣬱���Ѱ�õĹؼ������ϴαȱ仯����
        %����Ϊ�ϴ�Ѱ�ҵĹؼ�����Ϊ����Ѱ�ҵ��Ĺؼ��������������ű���
        if(match_now/match_last<1.2&&scale>=0.2)
            match_num=match_last;
            break;
        end
        match_last=match_now;
    end
    %���Ѱ�õ�ƥ���������ģ��ؼ�������ʮ��֮һ������Ϊ��Ѱ��ƥ�䣬����ģ�����
    if(match_num>0.1*keypoint2)
        %��ӡʶ����
        fprintf('\nFound objec at objec[ %d]\n',i);
        break;
    end
end

